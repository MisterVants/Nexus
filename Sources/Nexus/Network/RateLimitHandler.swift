//
//  RateLimitHandler.swift
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

fileprivate typealias RateLimitError = NexusError

protocol RateLimitBucket: AnyObject {
    func holdToken() throws
    func releaseToken()
    func resolveDynamicLimits(_ receivedLimits: [RateLimitData])
}

class RateLimitHandler: RateLimitBucket {
    
    private(set) var hasDefinedRateLimits: Bool
    private var rateLimits: [RateLimit]
    
    init() {
        self.rateLimits = [RateLimit(refreshTime: -1, limit: 1, usedLimits: 0)]
        self.hasDefinedRateLimits = false
    }
    
    init(rateLimits: [RateLimit]) {
        self.rateLimits = rateLimits
        self.hasDefinedRateLimits = true
    }
    
    var currentLimitStatus: [RateLimitData] {
        rateLimits.map { RateLimitData(refreshTime: $0.refreshTime, limit: $0.limitValue, currentCount: $0.count) }
    }
    
    var hasReachedLimit: Bool {
        for index in rateLimits.indices {
            if rateLimits[index].hasReachedLimit {
                return true
            }
        }
        return false
    }
    
    @discardableResult
    func useLimit() -> Bool {
        if !hasReachedLimit {
            for index in rateLimits.indices {
                rateLimits[index].yield()
            }
            return true
        }
        return false
    }
    
    func holdToken() throws {
        guard !hasReachedLimit else {
            guard hasDefinedRateLimits else {
                throw RateLimitError.rateLimitUndefined
            }
            throw RateLimitError.rateLimitExceeded
        }
        for index in rateLimits.indices {
            rateLimits[index].yield()
        }
    }
    
    func releaseToken() {
        releaseToken(consuming: false)
    }
    
    func releaseToken(consuming: Bool) {
        for index in rateLimits.indices {
            rateLimits[index].release(consume: consuming)
        }
    }
    
    func resolveDynamicLimits(_ receivedLimits: [RateLimitData]) {
        
        func removeUnhandledLimits(from receivedLimits: [RateLimitData]) {
            rateLimits = rateLimits.filter { rateLimit -> Bool in
                receivedLimits.contains(where: {$0.refreshTime == rateLimit.refreshTime})
            }
        }
        
        // If no info about rate limit is received (call failed / headers returned empty), just release the tokens
        guard !receivedLimits.isEmpty else {
            releaseToken(consuming: false)
            return
        }
        
        // Clean buckets not present in received data
        removeUnhandledLimits(from: receivedLimits)
        
        // Update Rate Limits
        receivedLimits.forEach { updateRateLimits(for: $0) }
        
        // Consume limits on success
        releaseToken(consuming: true)
        
        hasDefinedRateLimits = true
    }
    
    private func updateRateLimits(for limitData: RateLimitData) {
        if !rateLimits.contains(where: { $0.refreshTime == limitData.refreshTime}) {
            rateLimits.append(RateLimit(refreshTime: limitData.refreshTime, limit: limitData.limit, usedLimits: limitData.currentCount))
        } else {
            if let index = rateLimits.firstIndex(where: { $0.refreshTime == limitData.refreshTime}) {
                if rateLimits[index].limitValue != limitData.limit {
                    rateLimits[index].updateLimit(limitData)
                }
            }
        }
    }
}
