//
//  File.swift
//  
//
//  Created by Mohamed Aglan on 7/23/24.
//

import Foundation

public class NumberHelper {
    
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
