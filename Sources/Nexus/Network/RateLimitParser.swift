//
//  RateLimitParser.swift
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

// TODO: replace print for logs
enum RateLimitParser {
    
    struct ParsedLimit: Equatable {
        let limit: Int
        let refreshTime: Int
    }
    
    static func parseRateLimitHeaders(_ headers: [AnyHashable : Any]) -> (app: [RateLimitData], method: [RateLimitData]) {
        let appRateLimitsValue      = headers[RateLimit.HeaderKey.appLimit] as? String ?? ""
        let appRateLimitsCount      = headers[RateLimit.HeaderKey.appCount] as? String ?? ""
        let methodRateLimitsValue   = headers[RateLimit.HeaderKey.methodLimit] as? String ?? ""
        let methodLimitsCount       = headers[RateLimit.HeaderKey.methodCount] as? String ?? ""
        
        let appRateLimits           = parseRateLimits(totalRateLimitsString: appRateLimitsValue, rateLimitsUsageString: appRateLimitsCount)
        let methodRateLimits        = parseRateLimits(totalRateLimitsString: methodRateLimitsValue, rateLimitsUsageString: methodLimitsCount)
        return (app: appRateLimits, method: methodRateLimits)
    }
    
    private static func parseRateLimits(totalRateLimitsString: String, rateLimitsUsageString: String) -> [RateLimitData] {
        let defaultLimits   = totalRateLimitsString.split(separator: ",").compactMap { parseRateLimitPair(String($0)) }
        let usedLimits      = rateLimitsUsageString.split(separator: ",").compactMap { parseRateLimitPair(String($0)) }
        
        guard defaultLimits.count == usedLimits.count else {
            print("!!! rate limit pairs not symmetric")
            return []
        }
        
        return defaultLimits.enumerated().compactMap { (index, limit) -> RateLimitData? in
            guard limit.refreshTime == usedLimits[index].refreshTime else { return nil }
            return RateLimitData(refreshTime: limit.refreshTime,
                                 limit: limit.limit,
                                 currentCount: usedLimits[index].limit)
        }
    }
    
    private static func parseRateLimitPair(_ rateLimitPair: String) -> ParsedLimit? {
        let valuesPair = rateLimitPair.split(separator: ":")
        guard valuesPair.count == 2, let numberOfCalls = Int(valuesPair[0]), let timeValue = Int(valuesPair[1]) else {
            print("!!! Malformed string in rate limit pair")
            return nil
        }
        return ParsedLimit(limit: numberOfCalls, refreshTime: timeValue)
    }
}
