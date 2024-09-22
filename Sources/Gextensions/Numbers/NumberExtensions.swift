//
//  File.swift
//  
//
//  Created by Mohamed Aglan on 9/3/24.
//

import Foundation

public extension Double {
    var string: String {
        guard !(self.isNaN || self.isInfinite) else {
            return "0"
        }
        
        if self == Double(Int(self)) {
            return "\(Int(self))"
        } else {
            return self / 100 == 1 ? "100" : String(format: "%.1f", self)
        }
    }
    
    var stringWithTwoPoint: String {
        guard !(self.isNaN || self.isInfinite) else {
            return "0"
        }
        
        if self == Double(Int(self)) {
            return "\(Int(self))"
        } else {
            return String(format: "%.2f", self)
        }
    }
}

public extension Int64 {
    
    var KB: Double { return Double(self)/1024 }
    var MB: Double { return self.KB/1024 }
    var GB: Double { return self.MB/1024 }
    
    var bytesFormatted: String {
        guard self > 0 else {
            return "\u{200E}0 KB"
        }
        
        let suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"]
        let k: Double = 1000
        let i = floor(log(Double(self)) / log(k))
        
        let format = "\u{200E}%.\(i < 2 ? 0 : 1)f %@"
        let number = Float(Double(self) / pow(k, i))
        let suffix = suffixes[Int(i)]
        return String(format: format, number, suffix)
    }
    
    var timeInSecondsToArabicText: String {
        let daysArr  = [localizedString("يوم"), localizedString("يومين"), localizedString("أيام")]
        let hoursArr = [localizedString("ساعة"), localizedString("ساعتين"), localizedString("ساعات")]
        let minsArr  = [localizedString("دقيقة"), localizedString("دقيقتين"), localizedString("دقائق")]
        let secsArr  = [localizedString("ثانية"), localizedString("ثانيتين"), localizedString("ثواني")]
        
        let hours = self / 3600
        let minutes = (self % 3600) / 60
        let seconds = self % 60
        let days = hours / 24
        
        var remainingTime = ""
        
        if days > 0 {
            remainingTime = days.toArabicText(words: daysArr, withAL: false)
        } else {
            if hours > 0 {
                remainingTime = hours.toArabicText(words: hoursArr, withAL: false) + (minutes > 0 ? localizedString(" و ") : "")
            }
            if minutes > 0 {
                let totalMin = minutes + (seconds >= 25 ? 1 : 0)
                remainingTime += totalMin.toArabicText(words: minsArr, withAL: false)
            } else if seconds >= 30 && remainingTime.isEmpty {
                remainingTime = seconds.toRoundedArabicText(interval: 10, words: secsArr)
            } else if seconds < 30 && remainingTime.isEmpty {
                remainingTime = seconds.toRoundedArabicText(interval: 5, words: secsArr)
            } else if seconds < 10 && remainingTime.isEmpty {
                remainingTime = seconds.toArabicText(words: secsArr, withAL: false)
            }
        }
        
        return remainingTime
    }
    
    private func localizedString(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
    private func toArabicText(words: [String], withAL al: Bool = true) -> String {
        switch self {
        case 1:
            return (al ? localizedString("ال") : "") + words[0]
        case 2:
            return (al ? localizedString("ال") : "") + words[1]
        case 3...10:
            return "\(self) \(words[2])"
        default:
            return "\(self) \(words[0])"
        }
    }
    
    private func toRoundedArabicText(interval: Int64, words: [String]) -> String {
        let roundedValue = ((self + interval / 2) / interval) * interval
        return roundedValue.toArabicText(words: words, withAL: false)
    }
}

public extension Float {
    var string: String {
        guard !(self.isNaN || self.isInfinite) else {
            return "0"
        }
        
        if self == Float(Int(self)) {
            return "\(Int(self))"
        } else {
            return self / 100 == 1 ? "100" : String(format: "%.1f", self)
        }
    }
    
    var stringWithTwoPoint: String {
        guard !(self.isNaN || self.isInfinite) else {
            return "0"
        }
        
        if self == Float(Int(self)) {
            return "\(Int(self))"
        } else {
            return String(format: "%.2f", self)
        }
    }
}

