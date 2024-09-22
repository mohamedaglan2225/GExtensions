// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import CommonCrypto

public extension String {
    
    subscript(range: Range<Int>) -> String {
        guard range.lowerBound <= count && range.upperBound <= count else { return "" }
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        let endIndex = index(self.startIndex, offsetBy: range.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
    subscript(index: Int) -> String {
        return String(self[self.index(startIndex, offsetBy: index)])
    }
    
    subscript(range: CountableClosedRange<Int>) -> String {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        let endIndex = index(self.startIndex, offsetBy: range.upperBound)
        return String(self[startIndex...endIndex])
    }
    
    func containsIgnoringCase(_ searchString: String) -> Bool {
        return range(of: searchString, options: .caseInsensitive) != nil
    }

    var searchWord: String {
        return self.regex("(?<=\\/search\\?(?>q|p)=)(?=(.*?(?=&))|(.*(?!&)))").last?.last ?? ""
    }
    
    var getDomainFromURL: String {
        return self.regex("^(?:http:\\/\\/|www\\.|https:\\/\\/)(www\\.)?([^\\/]+)").last?.last ?? ""
    }
    
    func search(string: String, ignoreCase: Bool = true, ignoreDiacritic: Bool = true) -> Bool {
        var options: String.CompareOptions = []
        if ignoreCase { options.insert(.caseInsensitive) }
        if ignoreDiacritic { options.insert(.diacriticInsensitive) }
        return self.range(of: string, options: options) != nil
    }
    
    func regex(_ pattern: String) -> [[String]] {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return [] }
        let nsString = self as NSString
        let results = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
        return results.map { result in
            (0..<result.numberOfRanges).compactMap {
                result.range(at: $0).location != NSNotFound ? nsString.substring(with: result.range(at: $0)) : nil
            }
        }
    }
    
    func regexWithoutExtraSpaces(_ pattern: String) -> [[String]] {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return [] }
        let nsString = self as NSString
        let results = regex.matches(in: self, options: [.reportCompletion], range: NSMakeRange(0, nsString.length))
        return results.map { result in
            (0..<result.numberOfRanges).compactMap {
                result.range(at: $0).location != NSNotFound ? nsString.substring(with: result.range(at: $0)) : nil
            }
        }
    }
    
    func regexMatches(pattern: String) -> [NSTextCheckingResult] {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return [] }
        return regex.matches(in: self, options: [.reportCompletion], range: NSMakeRange(0, self.utf16.count))
    }
    
    func trimming() -> String {
        var trimmedString = self.trimmingCharacters(in: .whitespaces)
        trimmedString = trimmedString.replacingOccurrences(of: "\\p{Cf}", with: "", options: .regularExpression)
        return trimmedString
    }
    
    func encodeUrl() -> String {
        let unreserved = "-._~/?"
        var allowed = CharacterSet.alphanumerics
        allowed.insert(charactersIn: unreserved)
        return self.addingPercentEncoding(withAllowedCharacters: allowed) ?? self
    }
    
    func decodeUrl() -> String {
        return self.removingPercentEncoding ?? self
    }
    
    func isURL() -> Bool {
        if self.hasPrefix("https://") || self.hasPrefix("http://") || self.hasPrefix("ftp://") {
            return true
        }
        let regex = "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"
        return self.range(of: regex, options: .regularExpression) != nil
    }
    
    var getLocalPath: String {
        return self.regex(".*Application\\/.*?(\\/.*)").last?.last ?? self
    }
    
    var getSystemPathFromLocalPath: String {
        let url = URL(fileURLWithPath: self)
        if url.pathComponents.count > 2, url.pathComponents[1] == "private" {
            return self
        } else {
            return "\(NSHomeDirectory())\(self)"
        }
    }
    
    func removingIllegalCharacters() -> String {
        let illegalCharacters = CharacterSet(charactersIn: "/\\?%*|\"<>")
        return self.components(separatedBy: illegalCharacters).joined(separator: "")
    }
    
    var getLastFolder: String {
        if let R = self.regex("(.+?)\\/").last?.last {
            return R
        } else {
            return ""
        }
    }
    
    var getPathFolder: String {
        if let R = self.regex("(.+)\\/").last?.last {
            return R
        } else {
            return ""
        }
    }
    
    var getNameFromPath: String {
        if let R = self.regex("\\/([^\\/]+)$").last?.last {
            return R
        } else {
            return ""
        }
    }
    
    var getVisiblePath: String {
        let mainPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return self.replacingOccurrences(of: mainPath, with: "")
    }
    
    var getPathFromVisible: String {
        let mainPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let url = URL(fileURLWithPath: self)
        if url.pathComponents.count > 2, url.pathComponents[1] == "private" {
            return self
        } else {
            return "\(mainPath)\(self)"
        }
    }
    
    var formatEx: String {
        return (((self.regex("\\.\\w+$").last ?? [""]).last) ?? "")
    }
    
    var format: String {
        return self.formatEx.lowercased()
    }
    
    var removeType: String {
        return self.replacingOccurrences(of: self.formatEx, with: "")
    }
    
    func add(file: String) -> String {
        if self.last == "/" && file.first == "/" {
            var s = self
            s.removeLast()
            return "\(s)\(file)"
        } else if self.last == "/" || file.first == "/" {
            return "\(self)\(file)"
        } else {
            return "\(self)/\(file)"
        }
    }
    
    private func sha256() -> String {
        guard let inputData = self.data(using: .utf8) else { return "" }
        
        var hashedData = Data(count: Int(CC_SHA256_DIGEST_LENGTH))
        
        _ = hashedData.withUnsafeMutableBytes { hashedBytes in
            inputData.withUnsafeBytes { inputBytes in
                CC_SHA256(inputBytes.baseAddress, CC_LONG(inputData.count), hashedBytes.bindMemory(to: UInt8.self).baseAddress)
            }
        }
        
        return hashedData.map { String(format: "%02x", $0) }.joined()
    }
    
    func getHash() -> String {
        let privateHashKey = "Private"
        let privateHashId = retrieveOrGeneratePrivateHashId(forKey: privateHashKey)
        let seed = "prRlyz3KKr-\(self)"
        let hashKey = privateHashId + seed
        return hashKey.sha256()
    }
    
    private func retrieveOrGeneratePrivateHashId(forKey key: String) -> String {
        if let existingId = UserDefaults.standard.string(forKey: key), !existingId.isEmpty {
            return existingId
        } else {
            let newId = UUID().uuidString
            UserDefaults.standard.set(newId, forKey: key)
            return newId
        }
    }
}

public extension NSTextCheckingResult {
    func getTag(_ name: String, from text: String) -> String? {
        if let range = Range(self.range(withName: name), in: text) {
            return String(text[range])
        }
        return nil
    }
}
