//
//  File.swift
//  
//
//  Created by Mohamed Aglan on 9/3/24.
//

import AVKit

public extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}

