//
//  File.swift
//  
//
//  Created by Mohamed Aglan on 9/3/24.
//

import UIKit

public extension UIView {
    
    enum ViewSide {
        case left, right, top, bottom
    }
    
    func rightToLeft() {
        self.semanticContentAttribute = .forceRightToLeft
        for view in self.subviews {
            view.semanticContentAttribute = .forceRightToLeft
            view.rightToLeft()
        }
    }
}

public class ViewHelper {
    
    public static func addBorder(to view: UIView, side: UIView.ViewSide, color: CGColor, thickness: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color
        
        switch side {
        case .left:
            border.frame = CGRect(x: view.frame.minX, y: view.frame.minY, width: thickness, height: view.frame.height)
        case .right:
            border.frame = CGRect(x: view.frame.maxX, y: view.frame.minY, width: thickness, height: view.frame.height)
        case .top:
            border.frame = CGRect(x: view.frame.minX, y: view.frame.minY, width: view.frame.width, height: thickness)
        case .bottom:
            border.frame = CGRect(x: view.frame.minX, y: view.frame.maxY, width: view.frame.width, height: thickness)
        }
        
        view.layer.addSublayer(border)
    }
}

