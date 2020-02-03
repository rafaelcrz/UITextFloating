//
//  ViewController.swift
//  UITextFloating_Example
//
//  Created by Rafael Ramos on 12/10/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import UITextFloating

class ViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    let inputs: [String] = ["First Name", "Las Name", "E-mail", "Age", "Password"]
    
    
    init() {
        super.init(nibName: "ViewController", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITextFloatAppearance.shared.lineDefaultColor = .green
        UITextFloatAppearance.shared.lineTypingColor = .red
        UITextFloatAppearance.shared.lineErrorColor = .purple
        UITextFloatAppearance.shared.titleColor = .black
        UITextFloatAppearance.shared.textColor = .black
        
        let fieldName = UITextFloat(frame: CGRect(x: 0, y: 0, width: stackView.frame.width, height: 60))
        fieldName.floatLabel = "Full name"
        fieldName.secureTextEntry = true
        let fieldEmail = UITextFloat(frame: CGRect(x: 0, y: 0, width: stackView.frame.width, height: 60))
        fieldEmail.floatLabel = "E-mail"
        fieldEmail.errorLabel = "Parece que esse e-mail não é valido"
        let fieldAge = UITextFloat(frame: CGRect(x: 0, y: 0, width: stackView.frame.width, height: 60))
        fieldAge.floatLabel = "Age"
        stackView.addArrangedSubview(fieldName)
        stackView.addArrangedSubview(fieldEmail)
        stackView.addArrangedSubview(fieldAge)
        
    }
}
