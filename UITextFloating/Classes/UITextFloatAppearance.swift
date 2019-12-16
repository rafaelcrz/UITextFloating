//
//  UITextFloatAppearance.swift
//  UITextFloating
//
//  Created by Rafael Ramos on 12/10/19.
//

import Foundation

public class UITextFloatAppearance {
    
    public static var shared = UITextFloatAppearance()
    
    public var textColor: UIColor?
    public var lineTypingColor: UIColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    public var lineErrorColor: UIColor = .red
    public var lineDefaultColor: UIColor = .lightGray
    public var placeHolderColor: UIColor = .lightGray
    public var titleColor: UIColor = .lightGray
    
    init() {}
}
