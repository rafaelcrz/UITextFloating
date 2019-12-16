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
        
        for input in inputs {
            let textField = UITextFloat(frame: CGRect(x: 0, y: 0, width: stackView.frame.width, height: 60))
            textField.floatLabel = input
            //                textField.errorLabel = input
            stackView.addArrangedSubview(textField)
        }
        
        //
        //        let appearance = UITextFloatAppearance.shared
        //            .setTextColor(.red)
        //            .setLineTypingColor(.green)
        //
        //        float1.setup(appearance: appearance)
        //
        //        uiFloatTextA.addSubview(float1)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        view.endEditing(true)
    }
    
}
