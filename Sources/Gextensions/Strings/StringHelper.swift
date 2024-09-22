//
//  File.swift
//  
//
//  Created by Mohamed Aglan on 9/3/24.
//

import Foundation
import UIKit

public class StringHelper {
    
    public static func randomString(length: Int) -> String {
        let letters: NSString = "0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    public static func textWidth(text: String, font: UIFont?) -> CGFloat {
        let attributes = font != nil ? [NSAttributedString.Key.font: font] : [:]
        return text.size(withAttributes: attributes as [NSAttributedString.Key : Any]).width
    }
    
    public static func arabicToInt(_ num: String) -> Int {
        var num = num
        num = num.replacingOccurrences(of: "٠", with: "0")
        num = num.replacingOccurrences(of: "١", with: "1")
        num = num.replacingOccurrences(of: "٢", with: "2")
        num = num.replacingOccurrences(of: "٣", with: "3")
        num = num.replacingOccurrences(of: "٤", with: "4")
        num = num.replacingOccurrences(of: "٥", with: "5")
        num = num.replacingOccurrences(of: "٦", with: "6")
        num = num.replacingOccurrences(of: "٧", with: "7")
        num = num.replacingOccurrences(of: "٨", with: "8")
        num = num.replacingOccurrences(of: "٩", with: "9")
        return Int(num) ?? -1
    }
    
    public static func arabicToFloat(_ num: String) -> Float? {
        var num = num
        num = num.replacingOccurrences(of: "٠", with: "0")
        num = num.replacingOccurrences(of: "١", with: "1")
        num = num.replacingOccurrences(of: "٢", with: "2")
        num = num.replacingOccurrences(of: "٣", with: "3")
        num = num.replacingOccurrences(of: "٤", with: "4")
        num = num.replacingOccurrences(of: "٥", with: "5")
        num = num.replacingOccurrences(of: "٦", with: "6")
        num = num.replacingOccurrences(of: "٧", with: "7")
        num = num.replacingOccurrences(of: "٨", with: "8")
        num = num.replacingOccurrences(of: "٩", with: "9")
        num = num.replacingOccurrences(of: "٫", with: ".")
        return Float(num)
    }
    
    public static func replaceArabicNumbers(_ num: String) -> String {
        var num = num
        num = num.replacingOccurrences(of: "٠", with: "0")
        num = num.replacingOccurrences(of: "١", with: "1")
        num = num.replacingOccurrences(of: "٢", with: "2")
        num = num.replacingOccurrences(of: "٣", with: "3")
        num = num.replacingOccurrences(of: "٤", with: "4")
        num = num.replacingOccurrences(of: "٥", with: "5")
        num = num.replacingOccurrences(of: "٦", with: "6")
        num = num.replacingOccurrences(of: "٧", with: "7")
        num = num.replacingOccurrences(of: "٨", with: "8")
        num = num.replacingOccurrences(of: "٩", with: "9")
        num = num.replacingOccurrences(of: "٫", with: ".")
        return num
    }
}

