//
//  UITextFloat.swift
//  Unigenda
//
//  Created by Rafael Ramos on 13/08/19.
//  Copyright © 2019 Rafael. All rights reserved.
//

import Foundation
import UIKit
import Lottie

protocol UITextFloatDelegate {
    func inputValidation(_ textFloat: UITextFloat, isValid: Bool)
    func uiTextFieldChanging(_ textFloat: UITextFloat, _ textField: UITextField)
}

@IBDesignable
class UITextFloat: UIView {
    
    var delegate: UITextFloatDelegate?
    
    @IBOutlet weak var uiLabelErrorMessage: UILabel!
    @IBOutlet weak var uiLabelFloat: UILabel!
    @IBOutlet weak var uiViewLine: UIView!
    @IBOutlet weak var uiViewState: UIView!
    @IBOutlet weak var uiTextFieldValue: UITextField!
    
    private let nibName = String(describing: UITextFloat.self)
    private var isValid: Bool = false
    private var uiEditHeight: CGFloat = 0
    
    private var errorAnimationView: AnimationView?
    
    func getUIText() -> UITextField {
        return self.uiTextFieldValue
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initFromNib()
    }
    
//    override func prepareForInterfaceBuilder() {
//        self.initFromNib()
//    }
    
    var text: String = "" {
        didSet {
            self.uiTextFieldValue.text = self.text
            if !self.text.isEmpty {
                self.uiLabelFloat.transform = .init(translationX: .zero, y: -(uiEditHeight))
            } else {
                self.uiLabelFloat.transform = .identity
            }
        }
    }
    
    @IBInspectable
    var floatLabel: String? = "" {
        didSet {
            self.uiLabelFloat.text = self.floatLabel
        }
    }
    
    @IBInspectable
    var required: Bool = true
    
    @IBInspectable
    var secureTextEntry: Bool = false {
        didSet {
            self.uiTextFieldValue.isSecureTextEntry = self.secureTextEntry
        }
    }
    
    @IBInspectable
    var errorLabel: String = "" {
        didSet {
            self.uiLabelErrorMessage.text = self.errorLabel
            if !self.errorLabel.isEmpty {
                self.errorState()
            } else {
                self.clearState()
            }
            
        }
    }
    
    func initFromNib() {
        guard let viewNib = Bundle(for: type(of: self)).loadNibNamed(self.nibName, owner: self, options: [:])?.first as? UIView else {
            return
        }
        
        viewNib.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewNib.frame = self.bounds
        addSubview(viewNib)
        
        self.addObservers()
        self.uiViewState.backgroundColor = .clear
        self.uiViewState.clipsToBounds = true
        self.uiTextFieldValue.addTarget(self, action: #selector(uiTextFieldChanging(_:)), for: .editingChanged)
        self.uiTextFieldValue.addTarget(self, action: #selector(uiTextFieldEndingEdit(_:)), for: .editingDidEnd)
        self.uiLabelErrorMessage.alpha = 0
        self.uiEditHeight = self.uiTextFieldValue.frame.height
        
        self.errorAnimationView = AnimationView(name: "error_animation")
        self.errorAnimationView?.frame = self.uiViewState.bounds
        if let animation = self.errorAnimationView {
            self.uiViewState.addSubview(animation)
            animation.play()
            self.uiViewState.alpha = 0
        }
        
    }
    
    @objc
    func willKeyBoardShow(notification: Notification) {
        self.uiLabelFloat.transform = .init(translationX: .zero, y: -(uiEditHeight))
    }
    
    @objc
    func willKeyBoardHide() {
        let textValue: String = self.uiTextFieldValue.text ?? ""
        
        if textValue.isEmpty {
            self.uiLabelFloat.transform = .identity
        }
    }
    
    @objc
    func uiTextFieldChanging(_ textField: UITextField) {
        self.delegate?.uiTextFieldChanging(self, textField)
        self.uiViewLine.backgroundColor = UIColor(named: "AppBlueMain")
    }
    
    @objc
    func uiTextFieldEndingEdit(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.uiViewLine.backgroundColor = .lightGray
        }
        
        //        guard let text = textField.text else {
        //            return
        //        }
        //
        //        if self.required && text.isEmpty {
        //            self.delegate?.inputValidation(self, isValid: false)
        //        } else {
        //            //            self.successState()
        //            self.delegate?.inputValidation(self, isValid: true)
        //        }
    }
    
    func errorState(){
        self.errorAnimationView?.play()
        UIView.animate(withDuration: 0.2) {
            self.uiLabelErrorMessage.alpha = 1
            self.uiViewLine.backgroundColor = .red
            self.uiViewState.alpha = 1
        }
    }
    func successState() {
        self.addAnimation(name: "success_animation")
    }
    func clearState() {
        self.uiLabelErrorMessage.alpha = 0
        self.uiViewState.alpha = 0
    }
    
    func addAnimation(name: String) {
        if let animation = self.errorAnimationView {
            animation.removeFromSuperview()
            self.uiViewState.addSubview(animation)
            animation.play()
        }
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(willKeyBoardShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willKeyBoardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
