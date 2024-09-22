//
//  File.swift
//  
//
//  Created by Mohamed Aglan on 9/3/24.
//

import Foundation

public class FileHelper {
    
    public static func getTitle(title: String, path: String, counterText: String = "") -> String {
        let fileManager = FileManager.default
        let titleWithoutType = title.removeType
        let type = title.formatEx
        
        let name = "\(titleWithoutType)\(counterText.isEmpty ? "" : " \(counterText)")\(type)"
        if !fileManager.fileExists(atPath: "\(path)/\(name)") {
            return name
        }
        
        var i = 1
        while true {
            i += 1
            let name = "\(titleWithoutType) \(counterText.isEmpty ? "" : "\(counterText) ")\(i)\(type)"
            if !fileManager.fileExists(atPath: "\(path)/\(name)") {
                return name
            }
        }
    }
    
    public static func setupNewDate(to path: String) {
        let myDateObject = Date()
        let attributes = [FileAttributeKey.creationDate: myDateObject]
        do {
            try FileManager.default.setAttributes(attributes, ofItemAtPath: path)
        } catch {
            print(error)
        }
    }
}
