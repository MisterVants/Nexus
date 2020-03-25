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

import Foundation

struct RateLimitData: Equatable {
    let refreshTime: Int
    let limit: Int
    let currentCount: Int
}

struct RateLimit {
    
    enum HeaderKey {
        static let appLimit     = "X-App-Rate-Limit"
        static let appCount     = "X-App-Rate-Limit-Count"
        static let methodLimit  = "X-Method-Rate-Limit"
        static let methodCount  = "X-Method-Rate-Limit-Count"
    }
    
    static var now: () -> Date = Date.init
    
    let refreshTime             : Int
    private(set) var limitValue : Int
    private var usedLimits      : Int = 0
    private var expiringLimits  : [Date] = []
    
    var count: Int {
        expiringLimits.count + usedLimits
    }
    
    init(refreshTime: Int, limit: Int, usedLimits: Int = 0) {
        self.refreshTime = refreshTime
        self.limitValue = limit
        self.expiringLimits = (0..<usedLimits).map { _ in Self.now() }
    }
}

extension RateLimit {
    
    var hasReachedLimit: Bool {
        mutating get {
            cleanExpiredTokens()
            return count >= limitValue
        }
    }
    
    @discardableResult
    mutating func yield() -> Bool {
        if !hasReachedLimit {
            usedLimits += 1
            return true
        }
        return false
    }
    
    @discardableResult
    mutating func release(consume isConsuming: Bool = false) -> Bool {
        if usedLimits > 0 {
            usedLimits -= 1
            if isConsuming {
                expiringLimits.append(Self.now())
            }
            return true
        }
        return false
    }
    
    mutating func updateLimit(_ data: RateLimitData) {
        guard data.refreshTime == refreshTime else { return }
        self.limitValue = data.limit
    }
    
    mutating func cleanExpiredTokens() {
        expiringLimits = expiringLimits.filter { Self.now().timeIntervalSince($0) <= TimeInterval(refreshTime) }
    }
}
