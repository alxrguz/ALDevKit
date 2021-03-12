//
//  StringExtension.swift
//  Finance
//
//  Created by Alexandr Guzenko on 07.11.2020.
//  Copyright © 2020 Alexandr Guzenko. All rights reserved.
//

import Foundation

extension String {
    public func regex(pattern: String, options: NSRegularExpression.Options = []) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: options)
            let nsString = NSString(string: self)
            let results = regex.matches(in: self, options: [], range: NSRange(location: 0, length: nsString.length))
            return results.map { nsString.substring(with: $0.range) }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    /// Returns the position from the end of the last  digit of string
    public var lastNumberOffsetFromEnd: Int? {
        guard let indexOfLastNumber = lastIndex(where: { $0.isNumber }) else { return nil }
        let indexAfterLastNumber = index(after: indexOfLastNumber)
        return distance(from: endIndex, to: indexAfterLastNumber)
    }
}
