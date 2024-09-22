//
//  File.swift
//  
//
//  Created by Mohamed Aglan on 9/3/24.
//

import Foundation

public extension Date {
    func distanceToNow() -> TimeInterval {
        let refDate = self.timeIntervalSinceReferenceDate
        let nowDate = Date().timeIntervalSinceReferenceDate
        let diff = abs(refDate - nowDate)
        return diff
    }
    
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}
