//
//  File.swift
//  
//
//  Created by Mohamed Aglan on 7/23/24.
//

import UIKit

public class ImageHelper {
    
    public static func getSmallImageForDownload(_ type: String) -> UIImage? {
        if type == "video" {
            return #imageLiteral(resourceName: "Download Video")
        } else if type == "audio" {
            return #imageLiteral(resourceName: "Mute Off")
        }
        return nil
    }
    
    public static func maskWithColor(image: UIImage, color: UIColor) -> UIImage? {
        let maskImage = image.cgImage!
        
        let width = image.size.width
        let height = image.size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        UIGraphicsBeginImageContextWithOptions(image.size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        context.translateBy(x: 0, y: image.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return coloredImage
    }
    
    public static func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        context.translateBy(x: 0, y: newHeight)
        context.scaleBy(x: 1.0, y: -1.0)
        
        context.draw(image.cgImage!, in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    public static func saveImage(image: UIImage, path: String) -> Bool {
        if let data = image.pngData() {
            do {
                try data.write(to: URL(fileURLWithPath: path))
            } catch {
                return false
            }
        }
        return true
    }
}
