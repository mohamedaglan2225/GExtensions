//
//  File.swift
//  
//
//  Created by Mohamed Aglan on 9/3/24.
//

import UIKit

public extension UIButton {
    
    func alignVertical(spacing: CGFloat = 6.0) {
        guard let imageSize = self.imageView?.image?.size,
              let text = self.titleLabel?.text,
              let font = self.titleLabel?.font else { return }
        self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0.0)
        let labelString = NSString(string: text)
        let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: font])
        self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0.0, bottom: 0.0, right: -titleSize.width)
        let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0
        self.contentEdgeInsets = UIEdgeInsets(top: edgeOffset, left: 0.0, bottom: edgeOffset, right: 0.0)
    }
    
    func setRoundTheme(color: UIColor, fontSize: CGFloat = 15) {
        let background = color.withAlphaComponent(0.15)
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        self.setTitleColor(color, for: .normal)
        self.titleLabel?.font = font
        self.backgroundColor = background
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
    }
}

