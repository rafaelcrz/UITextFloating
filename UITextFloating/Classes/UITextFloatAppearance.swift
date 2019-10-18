//
//  UITextFloatAppearance.swift
//  UITextFloating
//
//  Created by Rafael Ramos on 12/10/19.
//

import Foundation

public class UITextFloatAppearance {
    
    public static var shared = UITextFloatAppearance()
    
    var textColor: UIColor?
    var lineTypingColor: UIColor = .lightGray
    
    init() {}
    
    public func setTextColor(_ color: UIColor) -> UITextFloatAppearance {
        self.textColor = color
        return self
    }
    
    public func setLineTypingColor(_ color: UIColor) -> UITextFloatAppearance {
        self.lineTypingColor = color
        return self
    }
}
