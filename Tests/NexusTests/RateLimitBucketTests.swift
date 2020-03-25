//
//  RateLimitBucketTests.swift
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

final class RateLimitBucketTests: XCTestCase {
    
    var bucket: RateLimitHandler!
    
    override func setUp() {
        super.setUp()
        bucket = RateLimitHandler()
    }
    
    override func tearDown() {
        bucket = nil
        super.tearDown()
    }
    
    // MARK: Init Tests
    
    func testBucket_initUndefined() {
        XCTAssert(bucket.hasDefinedRateLimits == false)
        XCTAssert(bucket.hasReachedLimit == false)
        XCTAssert(bucket.currentLimitStatus.count == 1)
        XCTAssert(bucket.currentLimitStatus.first?.limit == 1)
    }
    
    func testBucket_initDefined() {
        bucket = RateLimitHandler(rateLimits: [RateLimit(refreshTime: 1, limit: 1)])
        XCTAssert(bucket.hasDefinedRateLimits == true)
        XCTAssert(bucket.hasReachedLimit == false)
    }
    
    // MARK: Undefined Limits Tests
    
    func testBucket_undefinedLimits_canUseLimit() {
        XCTAssertTrue(bucket.useLimit())
    }
    
    func testBucket_undefinedLimits_cannotUseLimitTwice() {
        bucket.useLimit()
        XCTAssertFalse(bucket.useLimit())
    }
    
    func testBucket_undefinedLimits_reachesLimitInSingleCall() {
        bucket.useLimit()
        XCTAssertTrue(bucket.hasReachedLimit)
    }
    
    func testBucket_undefinedLimits_definesRateLimits() {
        let wildcard = bucket.currentLimitStatus.first!
        let limitA = RateLimitData(refreshTime: 1, limit: 10, currentCount: 1)
        let limitB = RateLimitData(refreshTime: 100, limit: 100, currentCount: 1)
        
        bucket.useLimit()
        bucket.resolveDynamicLimits([limitA, limitB])
        
        XCTAssert(bucket.hasDefinedRateLimits == true)
        XCTAssert(bucket.currentLimitStatus.contains(limitA))
        XCTAssert(bucket.currentLimitStatus.contains(limitB))
        XCTAssertFalse(bucket.currentLimitStatus.contains(wildcard), "receiving limits for the first time should remove wildcard rate limit")
    }
    
    // MARK: Defined Limits Tests
    
    func testBucket_definedLimits_reachLimitSingle() {
        bucket = RateLimitHandler(rateLimits: [RateLimit(refreshTime: 1, limit: 1)])
        bucket.useLimit()
        XCTAssertTrue(bucket.hasReachedLimit)
    }
    
    func testBucket_definedLimits_reachLimitMultiple() {
        bucket = RateLimitHandler(rateLimits: [
            RateLimit(refreshTime: 1, limit: 1),
            RateLimit(refreshTime: 100, limit: 10)
        ])
        bucket.useLimit()
        XCTAssertTrue(bucket.hasReachedLimit)
    }
    
    // MARK: Dynamic Rate Limits Tests
    
    func testBucket_handleLimits_emptyData() {
        bucket = RateLimitHandler(rateLimits: [RateLimit(refreshTime: 1, limit: 1)])
        bucket.useLimit()
        bucket.resolveDynamicLimits([])
        XCTAssertFalse(bucket.hasReachedLimit, "Receiving no data releases used limit")
    }
    
    func testBucket_handleLimits_updateLimitsUsage() {
        let limitA = RateLimitData(refreshTime: 1, limit: 10, currentCount: 1)
        let limitB = RateLimitData(refreshTime: 100, limit: 100, currentCount: 1)
        bucket = RateLimitHandler(rateLimits: [
            RateLimit(refreshTime: 1, limit: 10),
            RateLimit(refreshTime: 100, limit: 100)
        ])
        
        bucket.useLimit()
        bucket.resolveDynamicLimits([limitA, limitB])
        
        XCTAssert(bucket.currentLimitStatus.contains(limitA))
        XCTAssert(bucket.currentLimitStatus.contains(limitB))
    }
    
    func testBucket_handleLimits_removeUnhandledLimits() {
        bucket = RateLimitHandler(rateLimits: [
            RateLimit(refreshTime: 1, limit: 10),
            RateLimit(refreshTime: 100, limit: 100)
        ])
        
        bucket.useLimit()
        bucket.resolveDynamicLimits([
            RateLimitData(refreshTime: 100, limit: 100, currentCount: 1)
        ])
        
        XCTAssert(bucket.currentLimitStatus.contains { $0.refreshTime == 100 })
        XCTAssertFalse(bucket.currentLimitStatus.contains { $0.refreshTime == 1 })
    }
    
    func testBucket_handleLimits_updateLimitsCapacity() {
        bucket = RateLimitHandler(rateLimits: [
            RateLimit(refreshTime: 1, limit: 10),
            RateLimit(refreshTime: 100, limit: 100)
        ])
        bucket.useLimit()
        bucket.resolveDynamicLimits([
            RateLimitData(refreshTime: 1, limit: 20, currentCount: 1),
            RateLimitData(refreshTime: 100, limit: 50, currentCount: 1)
        ])
        
        XCTAssert(bucket.currentLimitStatus.contains { $0.refreshTime == 1 })
        XCTAssert(bucket.currentLimitStatus.contains { $0.refreshTime == 100 })
        XCTAssert(bucket.currentLimitStatus.contains { $0.limit == 20 })
        XCTAssert(bucket.currentLimitStatus.contains { $0.limit == 50 })
        XCTAssertFalse(bucket.currentLimitStatus.contains { $0.limit == 10 })
        XCTAssertFalse(bucket.currentLimitStatus.contains { $0.limit == 100 })
    }
    
    func testBucket_handleLimits_addNewLimits() {
        bucket = RateLimitHandler(rateLimits: [
            RateLimit(refreshTime: 1, limit: 10)
        ])
        bucket.useLimit()
        bucket.resolveDynamicLimits([
            RateLimitData(refreshTime: 1, limit: 10, currentCount: 1),
            RateLimitData(refreshTime: 100, limit: 100, currentCount: 1)
        ])
        
        XCTAssert(bucket.currentLimitStatus.contains { $0.refreshTime == 1 })
        XCTAssert(bucket.currentLimitStatus.contains { $0.refreshTime == 100 })
    }
    
    func testBucket_handleLimits_outOfOrder() {
        bucket = RateLimitHandler(rateLimits: [
            RateLimit(refreshTime: 1, limit: 10)
        ])
        bucket.useLimit()
        bucket.useLimit()
        bucket.useLimit()
        
        // Here, we trust the server and assume that it will respond correctly, but responses arrive at different times.
        bucket.resolveDynamicLimits([RateLimitData(refreshTime: 1, limit: 10, currentCount: 2)])
        bucket.resolveDynamicLimits([RateLimitData(refreshTime: 1, limit: 10, currentCount: 3)])
        bucket.resolveDynamicLimits([RateLimitData(refreshTime: 1, limit: 10, currentCount: 1)])
        
        XCTAssert(bucket.currentLimitStatus.first?.currentCount == 3)
    }
    
    func testBucket_handleLimits_limitRefreshing() {
        let timeMachine = TimeMachine()
        RateLimit.now = timeMachine.getDate
        bucket = RateLimitHandler(rateLimits: [
            RateLimit(refreshTime: 1, limit: 10)
        ])
        
        for i in 1...10 {
            bucket.useLimit()
            bucket.resolveDynamicLimits([RateLimitData(refreshTime: 1, limit: 10, currentCount: i)])
        }
        timeMachine.travel(by: 2)
        
        XCTAssertTrue(bucket.useLimit())
        RateLimit.now = Date.init
    }
}
