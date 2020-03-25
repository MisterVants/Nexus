//
//  RateLimitedProviderTests.swift
//
//  Copyright (c) 2020 André Vants
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import XCTest
@testable import Nexus

fileprivate struct APIMethodMock: APIMethod {
    let signature: String
    
    func endpointURL(from baseURL: URL) -> URL {
        return baseURL
    }
}

fileprivate extension APIRequest {
    
    static func mock(urlString: String = "https://httpbin.org/get", method: String? = nil) -> APIRequest {
        return APIRequest(url: URL(string: urlString)!, queryParameters: nil, httpHeaders: nil, method: APIMethodMock(signature: method ?? urlString))
    }
}

fileprivate extension RateLimitedProvider {
    
    var hasRunningRequest: Bool {
        return !runningRequests.isEmpty
    }
    
    var hasPendingRequests: Bool {
        return !pendingRequests.isEmpty
    }
    
    var hasPendingCallbacks: Bool {
        guard !pendingCallbacks.isEmpty else { return false }
        return !pendingCallbacks.allSatisfy { $0.value.isEmpty }
    }
}

fileprivate class RateLimitBucketMock: RateLimitBucket {
    
    var hasDefinedLimit = false
    var hasReachedLimit = false
    
    private(set) var count = 0
    
    func holdToken() throws {
        if hasReachedLimit {
            if hasDefinedLimit {
                throw NexusError.rateLimitExceeded
            }
            throw NexusError.rateLimitUndefined
        }
        count += 1
    }
    
    func releaseToken() {
        count -= 1
    }
    
    func resolveDynamicLimits(_ receivedLimits: [RateLimitData]) {
        releaseToken()
    }
}

final class RateLimitedProviderTests: XCTestCase {
    
    typealias TargetType = ChampionRotationInfo
    
    let emptyCompletion: (Response<TargetType>) -> Void = { _ in }
    
    var provider: RateLimitedProvider!
    var sessionMock: URLSessionMock!
    
    override func setUp() {
        super.setUp()
        sessionMock = URLSessionMock()
        provider = RateLimitedProvider(session: sessionMock)
    }
    
    override func tearDown() {
        provider = nil
        sessionMock = nil
        super.tearDown()
    }
    
    // MARK: Basic Request Tests
    
    func testRequest_start() {
        try? provider.perform(APIRequest.mock(), completion: emptyCompletion)
        XCTAssertTrue(provider.hasRunningRequest)
        XCTAssertTrue(sessionMock.didReceiveRequest)
    }
    
    func testRequest_finish() {
        let expectation = self.expectation(description: "")
        try? provider.perform(APIRequest.mock()) { (r: Response<TargetType>) in
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.1, handler: nil)
        XCTAssertFalse(provider.hasRunningRequest)
    }
    
    // MARK: Pending Requests Tests
    
    func testPendingRequest_undefinedRateLimitsForApp() {
        let appBucket = RateLimitBucketMock()
        appBucket.hasReachedLimit = true
        provider.appRateLimits = appBucket
        
        try? provider.perform(APIRequest.mock(), completion: emptyCompletion)
        
        XCTAssertTrue(provider.hasPendingRequests)
    }
    
    func testPendingRequest_undefinedRateLimitsForMethod() {
        let appBucket = RateLimitBucketMock()
        let methodBucket = RateLimitBucketMock()
        methodBucket.hasReachedLimit = true
        provider.buildRateLimitHandler = { methodBucket }
        provider.appRateLimits = appBucket
        
        try? provider.perform(APIRequest.mock(), completion: emptyCompletion)
        
        XCTAssertFalse(sessionMock.didReceiveRequest)
        XCTAssertFalse(provider.methodRateLimits.isEmpty)
        XCTAssert(provider.hasPendingRequests)
        XCTAssert(appBucket.count == 0)
    }
    
    // MARK: Pending Callbacks Tests
    
    func testCacheCallback_forPendingRequest_undefinedRateLimitsForApp() {
        let appBucket = RateLimitBucketMock()
        appBucket.hasReachedLimit = true
        provider.appRateLimits = appBucket
        
        let request = APIRequest.mock()
        try? provider.perform(request, completion: emptyCompletion)
        try? provider.perform(request, completion: emptyCompletion)
        
        XCTAssertFalse(sessionMock.didReceiveRequest)
        XCTAssert(provider.hasPendingCallbacks)
    }
    
    func testCacheCallback_forPendingRequest_undefinedRateLimitsForMethod() {
        let appBucket = RateLimitBucketMock()
        let methodBucket = RateLimitBucketMock()
        methodBucket.hasReachedLimit = true
        provider.appRateLimits = appBucket
        provider.buildRateLimitHandler = { methodBucket }
        
        let request = APIRequest.mock()
        try? provider.perform(request, completion: emptyCompletion)
        try? provider.perform(request, completion: emptyCompletion)
        
        XCTAssertFalse(sessionMock.didReceiveRequest)
        XCTAssert(provider.hasPendingCallbacks)
        XCTAssert(appBucket.count == 0)
    }
    
    // MARK: Request Rate Limit Exceeded Tests
    
    func testRequest_blocked_ifExceedsRateLimitsForApp() {
        let appBucket = RateLimitBucketMock()
        appBucket.hasReachedLimit = true
        appBucket.hasDefinedLimit = true
        provider.appRateLimits = appBucket
        
        let expectation = self.expectation(description: "")
        provider.send(APIRequest.mock()) { (response: Response<TargetType>) in
            XCTAssert((response.error as? NexusError)?.isRateLimitExceededError == true)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.1, handler: nil)
        XCTAssertFalse(sessionMock.didReceiveRequest)
    }
    
    func testRequest_blocked_ifExceedsRateLimitsForMethod() {
        let appBucket = RateLimitBucketMock()
        let methodBucket = RateLimitBucketMock()
        methodBucket.hasReachedLimit = true
        methodBucket.hasDefinedLimit = true
        provider.buildRateLimitHandler = { methodBucket }
        provider.appRateLimits = appBucket
        
        let expectation = self.expectation(description: "")
        provider.send(APIRequest.mock()) { (response: Response<TargetType>) in
            XCTAssert((response.error as? NexusError)?.isRateLimitExceededError == true)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.1, handler: nil)
        XCTAssertFalse(sessionMock.didReceiveRequest)
        XCTAssert(appBucket.count == 0)
    }
    
    // MARK: Real Model Integration Tests
    
    func testPendingRequest_afterSendingExplorerRequest() {
        let requestA = APIRequest.mock(urlString: "https://httpbin.org/get/A")
        let requestB = APIRequest.mock(urlString: "https://httpbin.org/get/B")
        
        try? provider.perform(requestA, completion: emptyCompletion)
        try? provider.perform(requestB, completion: emptyCompletion)
        
        XCTAssert(provider.hasPendingRequests)
        XCTAssert(!provider.methodRateLimits.isEmpty)
    }
    
    func testPendingRequest_restartOnRunningCallback() {
        let requestA = APIRequest.mock(urlString: "https://httpbin.org/get/A")
        let requestB = APIRequest.mock(urlString: "https://httpbin.org/get/B")
        
        let expectationA = self.expectation(description: "")
        let expectationB = self.expectation(description: "")
        provider.send(requestA) { (_: Response<TargetType>) in
            expectationA.fulfill()
        }
        provider.send(requestB){ (_: Response<TargetType>) in
            expectationB.fulfill()
        }
        
        wait(for: [expectationA], timeout: 0.1)
        XCTAssert(provider.hasPendingRequests == false)
        wait(for: [expectationB], timeout: 0.1)
    }
    
    // MARK: Concurrent Stress Tests
    
    func testConcurrentRequests_singleMethod() {
        let request = APIRequest.mock(urlString: "https://httpbin.org/get/A")
        let data = StubService.stubData(ChampionRotationInfo.self)
        
        let appBucket = RateLimitBucketMock()
        let methodBucket = RateLimitBucketMock()
        provider.appRateLimits = appBucket
        provider.buildRateLimitHandler = { methodBucket }
        
        sessionMock.stubData[try! request.asURL()] = data
        sessionMock.callbacksSuccess = true
        
        continueAfterFailure = false
        let group = DispatchGroup()
        
        DispatchQueue.concurrentPerform(iterations: 1000) { i in
            group.enter()
            provider.send(request) { (response: Response<TargetType>) in
                XCTAssert(response.httpResponse?.url == request.url)
                XCTAssert(response.data == data)
                XCTAssertNotNil(response.value)
                group.leave()
            }
        }
        
        let result = group.wait(timeout: .now() + 1)
        XCTAssert(result == .success)
        XCTAssertFalse(provider.hasRunningRequest)
        XCTAssertFalse(provider.hasPendingCallbacks)
        XCTAssertFalse(provider.hasPendingRequests)
        XCTAssert(appBucket.count == 0)
        XCTAssert(methodBucket.count == 0)
    }
    
    func testConcurrentRequests_multiMethod() {
        typealias TypeA = ChampionRotationInfo
        typealias TypeB = Summoner
        
        let requestA = APIRequest.mock(urlString: "https://httpbin.org/get/A")
        let requestB = APIRequest.mock(urlString: "https://httpbin.org/get/B")
        let dataA = StubService.stubData(TypeA.self)
        let dataB = StubService.stubData(TypeB.self)
        
        let appBucket = RateLimitBucketMock()
        let methodBucket = RateLimitBucketMock()
        provider.appRateLimits = appBucket
        provider.buildRateLimitHandler = { methodBucket }
        
        sessionMock.stubData[try! requestA.asURL()] = dataA
        sessionMock.stubData[try! requestB.asURL()] = dataB
        sessionMock.callbacksSuccess = true
        sessionMock.responseHeaders = [
            RateLimit.HeaderKey.appLimit        : "1000:1",
            RateLimit.HeaderKey.appCount        : "0:1",
            RateLimit.HeaderKey.methodLimit     : "1000:1",
            RateLimit.HeaderKey.methodCount     : "0:1",
        ]
        
        continueAfterFailure = false
        let group = DispatchGroup()
        
        DispatchQueue.concurrentPerform(iterations: 1000) { _ in
            group.enter()
            provider.send(requestA) { (response: Response<TypeA>) in
                XCTAssert(response.httpResponse?.url == requestA.url)
                XCTAssert(response.data == dataA)
                XCTAssertNotNil(response.value)
                group.leave()
            }
        }
        
        DispatchQueue.concurrentPerform(iterations: 1000) { _ in
            group.enter()
            provider.send(requestB) { (response: Response<TypeB>) in
                XCTAssert(response.httpResponse?.url == requestB.url)
                XCTAssert(response.data == dataB)
                XCTAssertNotNil(response.value)
                group.leave()
            }
        }
        
        let result = group.wait(timeout: .now() + 5)
        XCTAssert(result == .success)
        XCTAssertFalse(provider.hasRunningRequest)
        XCTAssertFalse(provider.hasPendingCallbacks)
        XCTAssertFalse(provider.hasPendingRequests)
        XCTAssert(appBucket.count == 0)
        XCTAssert(methodBucket.count == 0)
    }
}
