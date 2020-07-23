//
//  SmsViewController.swift
//  Messenger
//
//  Created by Valeriy Kovalevskiy on 7/22/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class SmsViewController: UIViewController {
    
    private let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "phone number"
        textField.textAlignment = .center
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.borderColor = UIColor.lightGray.cgColor

        return textField
    }()
    

    
    private let otpTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "otp"
        textField.textAlignment = .center
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.borderColor = UIColor.lightGray.cgColor

        textField.isHidden = true
        
        return textField
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.backgroundColor = .link
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
        return button
    }()
    
    var verificationId: String? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(phoneNumberTextField)
        view.addSubview(otpTextField)
        view.addSubview(submitButton)
        
        otpTextField.delegate = self
        phoneNumberTextField.delegate = self
        
        submitButton.addTarget(self, action: #selector(didTappedSubmitButton), for: .touchUpInside)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        phoneNumberTextField.frame = CGRect(x: 30,
                                            y: 100,
                                            width: view.width - 60,
                                            height: 52)
        otpTextField.frame = CGRect(x: 30,
                                    y: phoneNumberTextField.bottom + 10,
                                    width: view.width - 60,
                                    height: 52)
        submitButton.frame = CGRect(x: 30,
                                    y: otpTextField.bottom + 10,
                                    width: view.width - 60,
                                    height: 52)
    }
    
    @objc private func didTappedSubmitButton() {
        if otpTextField.isHidden {
            if !phoneNumberTextField.text!.isEmpty {
                Auth.auth().settings?.isAppVerificationDisabledForTesting = false
                 PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumberTextField.text!, uiDelegate: nil) { (id, error) in
                     guard error == nil else { return }
                     
                     self.verificationId = id
                     self.otpTextField.isHidden = false
                 }
            } else {
                print("Please enter you phone nunber")
            }
        }
        else {
            if let id = verificationId, let otp = otpTextField.text {
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: id, verificationCode: otp)
                Auth.auth().signIn(with: credential) { (authData, error) in
                    guard error == nil else { return print(error?.localizedDescription) }
                    
                    print("auth success " + (authData?.user.phoneNumber ?? "no phone number"))
                    
                }
            } else {
                print("error in getting verification id")
            }
        }
    }
    
}

extension SmsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == phoneNumberTextField {
            otpTextField.becomeFirstResponder()
        } else if textField == otpTextField {
            didTappedSubmitButton()
        }
        return true
    }
}

