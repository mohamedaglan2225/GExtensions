//
//  File.swift
//  
//
//  Created by Mohamed Aglan on 9/3/24.
//

import AVFoundation
import UIKit

public extension AVAsset {
    
    var realSize: CGSize {
        let s = g_size
        if g_orientation.isPortrait {
            return CGSize(width: s.height, height: s.width)
        } else {
            return s
        }
    }
    
    var presetName: String {
        return AVAssetExportPresetPassthrough
    }
    
    var presetName2: String {
        let size = self.realSize
        let max = max(size.height, size.width)
        if max >= 650 {
            return AVAssetExportPresetHighestQuality
        } else if max > 300 {
            return AVAssetExportPresetMediumQuality
        } else if max > 0 {
            return AVAssetExportPresetLowQuality
        } else {
            return AVAssetExportPresetHighestQuality
        }
    }
    
    var g_size: CGSize {
        return tracks(withMediaType: AVMediaType.video).first?.naturalSize ?? .zero
    }
    
    var g_orientation: UIInterfaceOrientation {
        guard let transform = tracks(withMediaType: AVMediaType.video).first?.preferredTransform else {
            return .portrait
        }
        
        switch (transform.tx, transform.ty) {
        case (0, 0):
            return .landscapeRight
        case (g_size.width, g_size.height):
            return .landscapeLeft
        case (0, g_size.width):
            return .portraitUpsideDown
        default:
            return .portrait
        }
    }
}

