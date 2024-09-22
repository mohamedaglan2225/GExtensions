//
//  File.swift
//  
//
//  Created by Mohamed Aglan on 9/3/24.
//

import UIKit
import AVKit

public class ToolsSwift: NSObject {
    
    public static let share = ToolsSwift()
    
    public func randomString(length: Int) -> String {
        return StringHelper.randomString(length: length)
    }
    
    public func getRateFormated(DS: Int64, CS: Int64) -> String {
        return "\(CS.bytesFormatted) « \(DS.bytesFormatted)"
    }
    
    public func videoSnapshot(url: URL) -> UIImage? {
        let asset = AVAsset(url: url)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        let time = CMTime(seconds: 2, preferredTimescale: 60)
        
        if let img = try? assetImgGenerate.copyCGImage(at: time, actualTime: nil) {
            return UIImage(cgImage: img).resizeImage(newWidth: 144)
        }
        return nil
    }
    
    public func timeFormated(sec: Double) -> String {
        var text = String(format: "%02d:%02d", ((lround(sec) / 60) % 60), lround(sec) % 60)
        
        if Int(((lround(sec) / 60 ) / 60)) > 0 {
            text = String(format: "%d:", ((lround(sec) / 60) / 60)) + text
        }
        
        return text
    }
    
    public func arabic(_ num: Int, _ T: [String], _ al: Bool = true) -> String {
        if num == 1 {
            return (al ? NSLocalizedString("ال", comment: "") : "") + T[0]
        } else if num == 2 {
            return (al ? NSLocalizedString("ال", comment: "") : "") + T[1]
        } else if num < 11 {
            return "\(num) \(T[2]) "
        }
        return "\(num) \(T[0]) "
    }
    
    public func presentNotificationForDownload(_ notifAction: String, notifBody: String) {
        NotificationHelper.presentNotificationForDownload(notifAction, notifBody: notifBody)
    }
    
    public func formatTime(elapsedTime: Float64, fullTime: Float64) -> String {
        var format = String(format: "%02d:%02d", ((lround(elapsedTime) / 60) % 60), lround(elapsedTime) % 60)
        
        if Int(((lround(fullTime) / 60 ) / 60)) > 0 {
            format = String(format: "%d:", ((lround(elapsedTime) / 60) / 60)) + format
        }
        
        return format
    }
    
    public func zeroFormatedTime(_ formatedTime: String) -> String {
        var zeroTime = formatedTime
        zeroTime = zeroTime.replacingOccurrences(of: "1", with: "0")
        zeroTime = zeroTime.replacingOccurrences(of: "2", with: "0")
        zeroTime = zeroTime.replacingOccurrences(of: "3", with: "0")
        zeroTime = zeroTime.replacingOccurrences(of: "4", with: "0")
        zeroTime = zeroTime.replacingOccurrences(of: "5", with: "0")
        zeroTime = zeroTime.replacingOccurrences(of: "6", with: "0")
        zeroTime = zeroTime.replacingOccurrences(of: "7", with: "0")
        zeroTime = zeroTime.replacingOccurrences(of: "8", with: "0")
        zeroTime = zeroTime.replacingOccurrences(of: "9", with: "0")
        return zeroTime
    }
    
    public func textWidth(text: String, font: UIFont?) -> CGFloat {
        return StringHelper.textWidth(text: text, font: font)
    }
    
    public func getTitle(Title: String, Path: String, counterText: String = "") -> String {
        return FileHelper.getTitle(title: Title, path: Path, counterText: counterText)
    }
    
    public func setupNewDate(to path: String) {
        FileHelper.setupNewDate(to: path)
    }
    
    public func getSize(url: URL?, request: URLRequest? = nil, completion: @escaping (_ size: Int64) -> Void) {
        NetworkHelper.getSize(url: url, request: request, completion: completion)
    }
    
    public func getSize(urls: [URL?], completion: @escaping (_ size: Int64) -> Void) {
        NetworkHelper.getSize(urls: urls, completion: completion)
    }
    
    public func askForPhotoPermission(completion: ((_ status: Bool) -> Void)? = nil) {
        PermissionHelper.askForPhotoPermission(completion: completion)
    }
    
    public func arabicToInt(_ num: String) -> Int {
        return NumberHelper.arabicToInt(num)
    }
    
    public func arabicToFloat(_ num: String) -> Float? {
        return NumberHelper.arabicToFloat(num)
    }
    
    public func replaceArabicNumbers(_ num: String) -> String {
        return NumberHelper.replaceArabicNumbers(num)
    }
    
    public func getSmallImageForDownload(_ type: String) -> UIImage? {
        return ImageHelper.getSmallImageForDownload(type)
    }
}

