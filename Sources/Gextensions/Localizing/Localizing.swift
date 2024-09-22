//
//  File.swift
//  
//
//  Created by Mohamed Aglan on 9/3/24.
//

import UIKit
import Foundation

public protocol Localizable {
    var localized: String { get }
}

extension String: Localizable {
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

