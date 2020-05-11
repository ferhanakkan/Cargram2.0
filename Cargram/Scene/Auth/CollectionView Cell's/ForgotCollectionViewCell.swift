//
//  ForgotCollectionViewCell.swift
//  Cargram
//
//  Created by Ferhan Akkan on 11.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

class ForgotColletionViewCell: UICollectionViewCell {
    
    let mainView = UIView()
    let title = UILabel()
    let mailInput = UITextField()
    let resetButton = UIButton()
    let bottomLabel = UILabel()
    let logInButton = UIButton()
    
    var delegate: CollectionViewIndexSelector?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setMainView()
        setTitle()
        setMailInput()
        setResetButton()
        setBottomLabel()
        setLogInButton()
    }
    required init?(coder: NSCoder) {
        fatalError("init has not been implemented")
    }
}

    //MARK: - Setup UI
extension ForgotColletionViewCell {
    
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
    
    private func setTitle() {
        mainView.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        title.numberOfLines = 0
        title.text = "We will send you a mail to reset your password"
        title.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    private func setMailInput() {
        mainView.addSubview(mailInput)
        mailInput.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        mailInput.placeholder = "E-mail"
        mailInput.borderStyle = .roundedRect
    }
    
    private func setResetButton() {
        mainView.addSubview(resetButton)
        resetButton.snp.makeConstraints { (make) in
            make.top.equalTo(mailInput.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        resetButton.setTitle("Reset Password", for: .normal)
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.backgroundColor = .gray
        resetButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        
    }
    
    private func setBottomLabel() {
        mainView.addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(resetButton.snp.bottom).offset(20)
            make.bottom.equalToSuperview().inset(20)
        }
        bottomLabel.text = "Did you remember your password?"
        bottomLabel.numberOfLines = 0
    }
    
    private func setLogInButton() {
        mainView.addSubview(logInButton)
        logInButton.snp.makeConstraints { (make) in
            make.leading.equalTo(bottomLabel.snp.trailing).offset(5)
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalTo(bottomLabel.snp.centerY)
            make.width.equalTo(50)
        }
        logInButton.setTitleColor(.gray, for: .normal)
        logInButton.setTitle("Log In", for: .normal)
        logInButton.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)
    }
    
}

//MARK: - Actions

extension ForgotColletionViewCell {
    @objc func resetButtonPressed() {
        if mailInput.text != "" {
            AppManager.shared.messagePresent(title: "OOOPS", message: "You didn't enter any e-mail", type: .error, isInternet: .nonInternetAlert)
        } else {
            // firebase action !!!
        }

    }
    
    @objc func logInButtonPressed() {
        delegate?.selectedCollectionViewIndex(row: 1)
    }
}