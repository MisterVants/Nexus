//
//  RateLimitParserTests.swift
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

final class RateLimitParserTests: XCTestCase {
    
    let appLimitKey         : String = RateLimit.HeaderKey.appLimit
    let appCountKey         : String = RateLimit.HeaderKey.appCount
    let methodLimitKey      : String = RateLimit.HeaderKey.methodLimit
    let methodCountKey      : String = RateLimit.HeaderKey.methodCount
    
    // MARK: Parse Success Tests
    
    func testParse_singleValueHeaders() {
        let headers: [AnyHashable : Any] = [
            appLimitKey     : "20:1",
            appCountKey     : "1:1",
            methodLimitKey  : "100:10",
            methodCountKey  : "2:10"
        ]
        let rateLimits = RateLimitParser.parseRateLimitHeaders(headers)
        
        XCTAssert(rateLimits.app.count                  == 1)
        XCTAssert(rateLimits.app.first?.limit           == 20)
        XCTAssert(rateLimits.app.first?.currentCount    == 1)
        XCTAssert(rateLimits.app.first?.refreshTime     == 1)
        
        XCTAssert(rateLimits.method.count               == 1)
        XCTAssert(rateLimits.method.first?.limit        == 100)
        XCTAssert(rateLimits.method.first?.currentCount == 2)
        XCTAssert(rateLimits.method.first?.refreshTime  == 10)
    }
    
    func testParse_multipleValueHeaders() {
        let headers: [AnyHashable : Any] = [
            appLimitKey     : "20:1,100:120",
            appCountKey     : "1:1,1:120",
            methodLimitKey  : "100:10,200:100,300:120",
            methodCountKey  : "1:10,2:100,3:120"
        ]
        let rateLimits = RateLimitParser.parseRateLimitHeaders(headers)
        
        XCTAssert(rateLimits.app.count      == 2)
        XCTAssert(rateLimits.method.count   == 3)
        
    }
    
    func testParse_onlyAppValues() {
        let headers: [AnyHashable : Any] = [
            appLimitKey : "20:1",
            appCountKey : "1:1"
        ]
        let rateLimits = RateLimitParser.parseRateLimitHeaders(headers)
        
        XCTAssertFalse(rateLimits.app.isEmpty)
        XCTAssertTrue(rateLimits.method.isEmpty)
    }
    
    func testParse_emptyHeaders() {
        let rateLimits = RateLimitParser.parseRateLimitHeaders([:])
        XCTAssertTrue(rateLimits.app.isEmpty)
        XCTAssertTrue(rateLimits.method.isEmpty)
    }
    
    func testParse_onlyValidPairs() {
        let partialHeaders: [AnyHashable : Any] = [
            appLimitKey     : "20:1,100:120",
            appCountKey     : "1:2,1:120",
            methodLimitKey  : "100:10:10,200:20,300:30",
            methodCountKey  : "1:10:10,1:20,1:30"
        ]
        let rateLimits = RateLimitParser.parseRateLimitHeaders(partialHeaders)
        
        XCTAssert(rateLimits.app.count      == 1)
        XCTAssert(rateLimits.method.count   == 2)
    }
    
    // MARK: Parse Failure Tests
    
    func testParseInvalid_asymmetricDurationPairs() {
        let asymmetricHeaders: [AnyHashable : Any] = [
            appLimitKey     : "20:1",
            appCountKey     : "1:2",
            methodLimitKey  : "100:10",
            methodCountKey  : "1:11"
        ]
        let rateLimits = RateLimitParser.parseRateLimitHeaders(asymmetricHeaders)
        
        XCTAssertTrue(rateLimits.app.isEmpty)
        XCTAssertTrue(rateLimits.method.isEmpty)
    }
    
    func testParseInvalid_asymmetricHeaders() {
        let asymmetricHeaders: [AnyHashable : Any] = [
            appLimitKey     : "20:1,100:120",
            appCountKey     : "1:1",
            methodLimitKey  : "100:10",
            methodCountKey  : "1:10,100:120"
        ]
        let rateLimits = RateLimitParser.parseRateLimitHeaders(asymmetricHeaders)
        
        XCTAssertTrue(rateLimits.app.isEmpty)
        XCTAssertTrue(rateLimits.method.isEmpty)
    }
    
    func testParseInvalid_countIncompletePairs() {
        let incompleteHeaders: [AnyHashable : Any] = [
            appLimitKey     : "20:1",
            methodLimitKey  : "100:10"
        ]
        let rateLimits = RateLimitParser.parseRateLimitHeaders(incompleteHeaders)
        
        XCTAssertTrue(rateLimits.app.isEmpty)
        XCTAssertTrue(rateLimits.method.isEmpty)
    }
    
    func testParseInvalid_limitIncompletePairs() {
        let incompleteHeaders: [AnyHashable : Any] = [
            appCountKey     : "20:1",
            methodCountKey  : "100:10"
        ]
        let rateLimits = RateLimitParser.parseRateLimitHeaders(incompleteHeaders)
        
        XCTAssertTrue(rateLimits.app.isEmpty)
        XCTAssertTrue(rateLimits.method.isEmpty)
    }
    
    func testParseInvalid_malformedPairs() {
        let malformedHeaders: [AnyHashable : Any] = [
            appLimitKey     : "20:1:1",
            appCountKey     : "1:1:1",
            methodLimitKey  : ":10",
            methodCountKey  : ":10"
        ]
        let rateLimits = RateLimitParser.parseRateLimitHeaders(malformedHeaders)
        
        XCTAssertTrue(rateLimits.app.isEmpty)
        XCTAssertTrue(rateLimits.method.isEmpty)
    }
}
