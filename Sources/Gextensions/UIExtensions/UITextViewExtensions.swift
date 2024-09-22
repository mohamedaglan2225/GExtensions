//
//  File.swift
//  
//
//  Created by Mohamed Aglan on 9/3/24.
//

import UIKit

public extension UITextView {
    
    private struct AssociatedKeys {
        static var placeholderKey = "placeholderKey" // Use a non-optional value for the key
    }
    
    var placeholder: String? {
        get {
            // Safely retrieve the associated object, casting it to String
            return objc_getAssociatedObject(self, &AssociatedKeys.placeholderKey) as? String
        }
        set {
            // Safely store the new value, ensuring it's non-optional
            objc_setAssociatedObject(self, &AssociatedKeys.placeholderKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            addPlaceholder(newValue)
        }
    }
    
    private func addPlaceholder(_ placeholderText: String?) {
        let placeholderLabel = UILabel()
        
        placeholderLabel.text = placeholderText ?? "" // Use empty string if placeholderText is nil
        placeholderLabel.sizeToFit()
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.tag = 100
        placeholderLabel.textAlignment = .right
        
        placeholderLabel.isHidden = self.text.count > 0
        self.addSubview(placeholderLabel)
        resizePlaceholder()
        self.delegate = self as? UITextViewDelegate // Safely cast the UITextView as UITextViewDelegate
    }
    
    private func resizePlaceholder() {
        guard let placeholderLabel = self.viewWithTag(100) as? UILabel else { return }
        
        let labelX = self.textContainer.lineFragmentPadding
        let labelY = self.textContainerInset.top - 2
        let labelWidth = self.frame.width - (labelX * 2) - 3
        let labelHeight = placeholderLabel.frame.height
        
        placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
    }
}
