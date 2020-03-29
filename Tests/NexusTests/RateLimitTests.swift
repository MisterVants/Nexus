//
//  RateLimit.swift
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

fileprivate extension RateLimit {
    
    static let defaultTime = 10
    static let defaultLimit = 5000
    
    static func makeAtMinimum() -> RateLimit {
        return RateLimit(refreshTime: defaultTime, limit: defaultLimit, usedLimits: 0)
    }
    
    static func makeAtMaximum() -> RateLimit {
        var limit = RateLimit(refreshTime: defaultTime, limit: defaultLimit, usedLimits: 0)
        (1...limit.limitValue).forEach { _ in limit.yield() }
        return limit
    }
    
    static func makeAtCurrent(value: Int) -> RateLimit {
        var limit = RateLimit(refreshTime: defaultTime, limit: defaultLimit, usedLimits: 0)
        (1...value).forEach { _ in limit.yield() }
        return limit
    }
    
    static func makeExpiringAtMaximum() -> RateLimit {
        return RateLimit(refreshTime: defaultTime, limit: defaultLimit, usedLimits: defaultLimit)
    }
    
    static func makeExpiringAtCurrent(value: Int) -> RateLimit {
        return RateLimit(refreshTime: defaultTime, limit: defaultLimit, usedLimits: value)
    }
}

final class RateLimitTests: XCTestCase {
    
    var timeMachine: TimeMachine!
    
    override func setUp() {
        super.setUp()
        timeMachine = TimeMachine()
        RateLimit.now = timeMachine.getDate
    }
    
    override func tearDown() {
        RateLimit.now = Date.init
        timeMachine = nil
        super.tearDown()
    }
    
    // MARK: Init Tests
    
    func testLimit_initEmpty() {
        var limit = RateLimit(refreshTime: 1, limit: 10, usedLimits: 0)
        XCTAssert(limit.count == 0)
        XCTAssert(limit.hasReachedLimit == false)
    }
    
    func testLimit_initFull() {
        var limit = RateLimit(refreshTime: 1, limit: 10, usedLimits: 10)
        XCTAssert(limit.count == limit.limitValue)
        XCTAssert(limit.hasReachedLimit == true)
        XCTAssert(limit.yield() == false)
        XCTAssert(limit.release() == false, "used limits passed on init turn into expiring tokens")
    }
    
    func testLimit_initOver() {
        var limit = RateLimit(refreshTime: 1, limit: 10, usedLimits: 100)
        XCTAssert(limit.count > limit.limitValue)
        XCTAssert(limit.hasReachedLimit == true)
    }
    
    // MARK: Empty State Tests
    
    func testLimit_empty_canYieldSingle() {
        var limit           = RateLimit.makeAtMinimum()
        let initialValue    = limit.count
        let yield           = limit.yield()
        XCTAssert(yield == true)
        XCTAssert(limit.count == initialValue + 1, "used limits must be incremented")
    }
    
    func testLimit_empty_canYieldAll() {
        var limit           = RateLimit.makeAtMinimum()
        let result          = (1...limit.limitValue).map { _ in limit.yield() }
        XCTAssert(!result.contains(false))
        XCTAssert(limit.count == limit.limitValue)
        XCTAssert(limit.hasReachedLimit, "yielding all tokens must reach limit")
    }
    
    func testLimit_empty_cannotReleaseLimit() {
        var limit           = RateLimit.makeAtMinimum()
        let initialValue    = limit.count
        let release         = limit.release()
        XCTAssert(release == false)
        XCTAssert(limit.count == initialValue, "used limits must remain constant")
    }
    
    // MARK: Limit Releasing Tests
    
    func testLimit_canReleaseTokens_consuming() {
        var limit           = RateLimit.makeAtCurrent(value: 10)
        let initialValue    = limit.count
        let release         = limit.release(consume: true)
        XCTAssert(release == true)
        XCTAssert(limit.count == initialValue, "consuming a released token retains it and schedules for expiration")
    }
    
    func testLimit_canReleaseTokens_withoutConsuming() {
        var limit           = RateLimit.makeAtCurrent(value: 10)
        let initialValue    = limit.count
        let release         = limit.release(consume: false)
        XCTAssert(release == true)
        XCTAssert(limit.count == initialValue - 1, "not consuming a released token frees it")
    }
    
    // MARK: Full Limits Used Tests
    
    func testLimit_full_cannotYieldMoreThanLimit() {
        var limit           = RateLimit.makeAtMaximum()
        let yield           = limit.yield()
        XCTAssertFalse(yield, "cannot yield token when at limit")
    }
    
    func testLimit_full_canReleaseAllTokens() {
        var limit           = RateLimit.makeAtMaximum()
        let releaseResult   = (1...limit.limitValue).map { _ in limit.release() }
        XCTAssert(!releaseResult.contains(false))
        XCTAssert(limit.count == 0, "used limits must return to zero")
    }
    
    func testLimit_full_canReleaseAllTokensConsuming() {
        var limit           = RateLimit.makeAtMaximum()
        let releaseResult   = (1...limit.limitValue).map { _ in limit.release(consume: true) }
        XCTAssert(!releaseResult.contains(false))
        XCTAssert(limit.hasReachedLimit, "consuming all tokens must keep limit at maximum")
    }
    
    func testLimit_full_cannotReleaseExpiringTokens() {
        var limit           = RateLimit.makeAtMaximum()
        (1...limit.limitValue).forEach { _ in limit.release(consume: true) }
        let release         = limit.release()
        XCTAssert(release == false, "expiring token cannot be released")
    }
    
    // MARK: Expiring Limits Tests
    
    func testLimit_afterExpirationTime_hasNotReachedLimits() {
        var limit = RateLimit.makeExpiringAtMaximum()
        timeMachine.travel(by: limit.refreshTime + 1)
        XCTAssertFalse(limit.hasReachedLimit)
        XCTAssert(limit.count < limit.limitValue)
    }
    
    func testLimit_afterExpirationTime_canYield() {
        var limit = RateLimit.makeExpiringAtMaximum()
        timeMachine.travel(by: limit.refreshTime + 1)
        XCTAssertTrue(limit.yield())
    }
    
    func testLimit_afterExpirationTime_onlyDropExpiredTokens() {
        let targetValue     = 100
        var limit           = RateLimit.makeExpiringAtCurrent(value: targetValue)
        (1...limit.limitValue/2).forEach { _ in limit.yield() }
        let totalCount      = limit.count
        timeMachine.travel(by: limit.refreshTime + 1)
        limit.cleanExpiredTokens()
        XCTAssert(limit.count == totalCount - targetValue)
    }
}
