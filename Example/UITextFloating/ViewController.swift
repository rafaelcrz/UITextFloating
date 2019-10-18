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
    
    @IBOutlet weak var uiFloatTextA: UITextFloat!
    
    init() {
        super.init(nibName: "ViewController", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let appearance = UITextFloatAppearance.shared
            .setTextColor(.red)
            .setLineTypingColor(.green)
        
        self.uiFloatTextA.setup(appearance: appearance)
        
        self.uiFloatTextA.text = "teste"
        self.uiFloatTextA.floatLabel = "FLOAT"
        
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}
