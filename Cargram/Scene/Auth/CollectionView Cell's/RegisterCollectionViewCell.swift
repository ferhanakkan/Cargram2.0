//
//  RegisterCollectionViewCell.swift
//  Cargram
//
//  Created by Ferhan Akkan on 11.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import BEMCheckBox

class RegisterColletionViewCell: UICollectionViewCell {
    
    let mainView = UIView()
    let emailInput = UITextField()
    let passwordInput = UITextField()
    let eyeButton = UIButton()
    let usernameInput = UITextField()
    let userAgreementLabel = UILabel()
    let userAgreementCheckBox = BEMCheckBox()
    let rememberLabel = UILabel()
    let checkBox = BEMCheckBox()
    let registerButton = UIButton()
    let bottomSubView = UIView()
    let bottomLabel = UILabel()
    let logInButton = UIButton()
    
    var delegate: CollectionViewIndexSelector?
    
    let firebase = FirebaseUserService()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setMainView()
        setEmailInput()
        setPasswordInput()
        setEye()
        setUsernameInput()
        setuserAgremmentLabel()
        setUserAgrementCheckBox()
        setRememberLabel()
        setCheckBox()
        setRegisterButton()
        setBottomSubView()
        setBottomLabel()
        setLogInButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init has not been implemented")
    }
}

    //MARK: - Setup UI
extension RegisterColletionViewCell {
    
    private func setMainView() {
        contentView.addSubview(mainView)
        mainView.backgroundColor = .white
        mainView.shadowAndCorner(radius: 20, shadowRadius: 7, opacity: 0.6, color: .black, width: 5, height: 5)
        mainView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setEmailInput() {
        mainView.addSubview(emailInput)
        emailInput.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.top.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        emailInput.placeholder = "E-mail"
        emailInput.borderStyle = .roundedRect
    }
    
    private func setPasswordInput() {
        mainView.addSubview(passwordInput)
        passwordInput.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.top.equalTo(emailInput.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        passwordInput.placeholder = "Password"
        passwordInput.isSelected = true
        passwordInput.borderStyle = .roundedRect
        passwordInput.isSecureTextEntry = true
    }
    
    private func setEye() {
        mainView.addSubview(eyeButton)
        eyeButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(30)
            make.centerY.equalTo(passwordInput.snp.centerY)
            make.trailing.equalToSuperview().inset(30)
        }
        eyeButton.setImage(UIImage(named: "eyeHidden"), for: .normal)
        eyeButton.addTarget(self, action: #selector(eyeButtonPressed), for: .touchUpInside)
    }
    
    private func setUsernameInput() {
        mainView.addSubview(usernameInput)
        usernameInput.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.top.equalTo(passwordInput.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        usernameInput.placeholder = "Username"
        usernameInput.borderStyle = .roundedRect
    }
    
    private func setuserAgremmentLabel() {
        mainView.addSubview(userAgreementLabel)
        userAgreementLabel.snp.makeConstraints { (make) in
            make.top.equalTo(usernameInput.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(40)
        }
        userAgreementLabel.text = "User Agreements"
        userAgreementLabel.textColor = .systemBlue
        let gest = UITapGestureRecognizer(target: self, action: #selector(userAgreementPressed))
        userAgreementLabel.addGestureRecognizer(gest)
        userAgreementLabel.isUserInteractionEnabled = true
    }
    
    private func setUserAgrementCheckBox() {
        mainView.addSubview(userAgreementCheckBox)
        userAgreementCheckBox.snp.makeConstraints { (make) in
            make.height.width.equalTo(15)
            make.centerY.equalTo(userAgreementLabel)
            make.leading.equalTo(userAgreementLabel.snp.trailing).offset(10)
        }
        userAgreementCheckBox.onTintColor = .orange
        userAgreementCheckBox.onCheckColor = .orange
    }
    
    private func setRememberLabel() {
        mainView.addSubview(rememberLabel)
        rememberLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userAgreementLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(40)
        }
        rememberLabel.text = "Remember Me"
    }
    
    private func setCheckBox() {
        mainView.addSubview(checkBox)
        checkBox.snp.makeConstraints { (make) in
            make.height.width.equalTo(15)
            make.centerY.equalTo(rememberLabel)
            make.leading.equalTo(rememberLabel.snp.trailing).offset(10)
        }
        checkBox.onTintColor = .orange
        checkBox.onCheckColor = .orange
    }
    
    private func setRegisterButton() {
        mainView.addSubview(registerButton)
        registerButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(rememberLabel.snp.bottom).offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        registerButton.backgroundColor = .gray
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.setTitle("Register", for: .normal)
        registerButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
    }
    
    private func setBottomSubView() {
        mainView.addSubview(bottomSubView)
        bottomSubView.snp.makeConstraints { (make) in
            make.top.equalTo(registerButton.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    private func setBottomLabel() {
        bottomSubView.addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints { (make) in
            make.leading.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        bottomLabel.text = "Did you register before?"
        bottomLabel.font = UIFont.systemFont(ofSize: 17)
    }
    
    private func setLogInButton() {
        bottomSubView.addSubview(logInButton)
        logInButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(bottomLabel.snp.centerY)
            make.leading.equalTo(bottomLabel.snp.trailing)
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(30)
            make.width.equalTo(60)
        }
        logInButton.setTitle("Log In", for: .normal)
        logInButton.setTitleColor(.orange, for: .normal)
        logInButton.addTarget(self, action: #selector(logInPressed), for: .touchUpInside)
    }
}

//MARK: - Actions

extension RegisterColletionViewCell {
    
    @objc private func userAgreementPressed() {
       let vc = UserAgreementViewController()
        UIApplication.getPresentedViewController()!.present(vc, animated: true)
    }
    
    @objc private func logInPressed() {
        delegate?.selectedCollectionViewIndex(row: 1)
    }
    
    @objc private func registerButtonPressed() {
        rememberMeSetter()
        if userAgreementCheckBox.on {
        if emailInput.text == "" || passwordInput.text == "" || usernameInput.text == "" {
            AppManager.shared.messagePresent(title: "OOOPS", message: "Please enter your E-mail or Password please", type: .error, isInternet: .nonInternetAlert)
        } else {
            LoadingView.show()
            firebase.createUser(email: emailInput.text!, password: passwordInput.text!, username: usernameInput.text!) { (_) in
                self.window?.rootViewController = Tabbar.createTabBarWithNavigationBar()
            }
        }
        } else {
            AppManager.shared.messagePresent(title: "OOPs", message: "To be registered you have to accept user agreements", type: .error, isInternet: .nonInternetAlert)
        }
    }
    
    @objc private func eyeButtonPressed() {
        passwordInput.isSecureTextEntry = !passwordInput.isSecureTextEntry
        DispatchQueue.main.async {
            self.setEyeImage()
        }
    }
    
    private func rememberMeSetter() {
        if checkBox.on {
            UserDefaults.standard.setValue(true, forKey: "rememberMe")
        } else {
           UserDefaults.standard.setValue(false, forKey: "rememberMe")
        }
    }
    
    private func setEyeImage() {
        if passwordInput.isSecureTextEntry {
            eyeButton.setImage(UIImage(named: "eyeHidden"), for: .normal)
        } else {
            eyeButton.setImage(UIImage(named: "eye"), for: .normal)
        }
    }
}
