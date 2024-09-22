// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public extension FileManager {
    
    func unique(name: String, folderPath: String, counterText: String = "") -> String {
        let ext = name.formatEx
        let name = name.removeType.removingIllegalCharacters()
        let counterText = counterText.isEmpty ? "" : " \(counterText)"
        
        var validatedName = "\(name)\(counterText)\(ext)"
        var tries = 1
        
        while FileManager.default.fileExists(atPath: "\(folderPath)/\(validatedName)") {
            validatedName = "\(name)\(counterText) \(tries)\(ext)"
            tries += 1
            if tries > 1000 {
                break
            }
        }
        
        return validatedName
    }

    func sizeOfFile(atPath path: String) -> Int64? {
        guard let attrs = try? attributesOfItem(atPath: path) else {
            return nil
        }
        
        return attrs[.size] as? Int64
    }
}
