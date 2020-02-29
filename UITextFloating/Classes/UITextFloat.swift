//
//  UITextFloat.swift
//  Unigenda
//
//  Created by Rafael Ramos on 13/08/19.
//  Copyright © 2019 Rafael. All rights reserved.
//

import Foundation
import UIKit

protocol UITextFloatDelegate {
    func inputValidation(_ textFloat: UITextFloat, isValid: Bool)
    func uiTextFieldChanging(_ textFloat: UITextFloat, _ textField: UITextField)
}

@IBDesignable
public class UITextFloat: UIView {
    private let animateDuration = 0.3
    private let textFieldHeight: CGFloat = 31
    lazy var uiStackViewContentView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UITextFloatAppearance.shared.lineDefaultColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var uiLabelFlow: UILabel = {
        let label = UILabel()
        label.textColor = UITextFloatAppearance.shared.placeHolderColor
        label.font = label.font.withSize(16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var uiLabelError: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .red
        label.font = label.font.withSize(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    public lazy var uiTextFieldValue: UITextField = {
        let textField = UITextField()
        textField.textColor = UITextFloatAppearance.shared.textColor
        textField.placeholder = ""
        textField.addTarget(self, action: #selector(uiTextFieldEndingEdit(_:)), for: .editingDidEnd)
        textField.addTarget(self, action: #selector(EditingChanged(_:)), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.rightViewMode = .always
        let buttonClose = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 40, height: 40)))
        buttonClose.alpha = 0
        buttonClose.setImage(UIImage(named: "clear", in: Bundle(for: type(of: self)), compatibleWith: nil), for: .normal)
        buttonClose.addTarget(self, action: #selector(self.clearText), for: .touchUpInside)
        textField.rightView = buttonClose
        return textField
    }()
    
    public var textFieldEndingEdit: (String) -> Void = {_ in }
    
    public var text: String {
        get {
            return self.uiTextFieldValue.text ?? ""
        }
    }
    
    var delegate: UITextFloatDelegate?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initFromNib()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.initFromNib()
        self.uiLabelError.text = "Error text"
        self.uiLabelFlow.text = "Text floating"
        self.uiTextFieldValue.text = "Text value"
        self.upLabelFloating()
    }
    
    public var secureTextEntry: Bool = false {
        didSet {
            self.uiTextFieldValue.isSecureTextEntry = self.secureTextEntry
        }
    }
    
    public var errorLabel: String? {
        didSet {
            self.uiLabelError.text = self.errorLabel
            if !(self.errorLabel?.isEmpty ?? true) {
                self.lineView.backgroundColor = UITextFloatAppearance.shared.lineErrorColor
            } else {
                self.lineView.backgroundColor = UITextFloatAppearance.shared.lineDefaultColor
            }
        }
    }
    public var floatLabel: String? {
        didSet {
            self.uiLabelFlow.text = self.floatLabel
        }
    }
    func initFromNib() {
        clipsToBounds = true
        uiStackViewContentView.frame = self.bounds
        uiStackViewContentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(uiStackViewContentView)
        uiStackViewContentView.addConstraintTo(toView: self)
        
        uiStackViewContentView.addArrangedSubview(uiLabelFlow)
        uiStackViewContentView.addArrangedSubview(uiTextFieldValue)
        uiStackViewContentView.addArrangedSubview(lineView)
        uiStackViewContentView.addArrangedSubview(uiLabelError)
        
        NSLayoutConstraint.activate([
            uiTextFieldValue.heightAnchor.constraint(equalToConstant: self.textFieldHeight),
            uiTextFieldValue.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            uiTextFieldValue.leftAnchor.constraint(equalTo: self.leftAnchor, constant: -0)
        ])
        NSLayoutConstraint.activate([
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
        NSLayoutConstraint.activate([
            uiLabelFlow.heightAnchor.constraint(equalToConstant: 22)
        ])
        self.downLabelFloating()
    }
    @objc
    func EditingChanged(_ textField: UITextField) {
        UIView.animate(withDuration: self.animateDuration) {
            if self.errorLabel?.isEmpty ?? true {
                self.lineView.backgroundColor = UITextFloatAppearance.shared.lineTypingColor
            }
            if textField.text?.isEmpty ?? true {
                self.downLabelFloating()
            } else {
                self.upLabelFloating()
            }
        }
    }
    @objc
    func uiTextFieldEndingEdit(_ textField: UITextField) {
        textFieldEndingEdit(textField.text ?? String())
        self.uiTextFieldValue.rightView?.alpha = 0
        UIView.animate(withDuration: self.animateDuration) {
            if self.errorLabel?.isEmpty ?? true {
                self.lineView.backgroundColor = UITextFloatAppearance.shared.lineDefaultColor
            }
        }
    }
    fileprivate func downLabelFloating() {
        self.uiTextFieldValue.rightView?.alpha = 0
        self.uiLabelFlow.textColor = UITextFloatAppearance.shared.placeHolderColor
        self.uiLabelFlow.transform = .init(translationX: .zero, y: textFieldHeight)
    }
    fileprivate func upLabelFloating() {
        self.uiTextFieldValue.rightView?.alpha = 1
        self.uiLabelFlow.textColor = UITextFloatAppearance.shared.titleColor
        self.uiLabelFlow.transform = .init(translationX: .zero, y: -(1))
    }
    
    @objc
    func clearText() {
        self.uiTextFieldValue.text = nil
        UIView.animate(withDuration: self.animateDuration) {
            self.downLabelFloating()
        }
    }
    override open var intrinsicContentSize: CGSize {
        return CGSize(width: bounds.size.width, height: bounds.size.height + 10)
    }
}

extension UIView {
    func addToCenter(to: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerYAnchor.constraint(equalTo: to.centerYAnchor).isActive = true
        self.centerXAnchor.constraint(equalTo: to.centerXAnchor).isActive = true
    }
    
    func addConstraintTo(toView view: UIView,
                         rightAnchor: CGFloat = 0,
                         leftAnchor: CGFloat = 0,
                         topAnchor: CGFloat = 0,
                         bottomAnchor: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: rightAnchor).isActive = true
        self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: leftAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomAnchor).isActive = true
        self.topAnchor.constraint(equalTo: view.topAnchor, constant: topAnchor).isActive = true
    }
}
