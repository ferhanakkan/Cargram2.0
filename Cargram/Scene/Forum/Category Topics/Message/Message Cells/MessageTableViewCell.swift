//
//  MessageTableViewCell.swift
//  Cargram
//
//  Created by Ferhan Akkan on 15.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

class MessageTableViewCell: UITableViewCell {
    
    let subView = UIView()
    let stackView = UIStackView()
    let messageBubble = UIView()
    let messageLabel = UILabel()
    let rightImageView = UIImageView()
    let leftImageView = UIImageView()
    let writenByLabel = UILabel()
    
    let firebase = FirebaseImageService()
    
    var message: MessageModel? = nil {
        didSet {
            if Auth.auth().currentUser!.displayName == message!.username {
                writenByLabel.textAlignment = .right
                messageLabel.textAlignment = .right
                rightImageView.isHidden = false
                leftImageView.isHidden = true
                messageLabel.text = message!.title
                writenByLabel.text = "Writen By:\(message!.username)"
                if let data = UserDefaults.standard.value(forKey: "profileImage") as? Data{
                    rightImageView.image = UIImage(data: data)
                }
            } else {
                writenByLabel.textAlignment = .left
                messageLabel.textAlignment = .left
                rightImageView.isHidden = true
                leftImageView.isHidden = false
                writenByLabel.text = "Writen By:\(message!.username)"
                messageLabel.text = message!.title
                firebase.getOtherUsersImage(username: message!.username) { (data) in
                    self.leftImageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}

//MARK: - Setup UI

extension MessageTableViewCell {
    
    private func setUI() {
        contentView.backgroundColor = .clear
        setSubView()
        setWritenBy()
        setStackView()
        setLeftImageView()
        setMessageBubble()
        setRightImageView()
    }
    
    private func setSubView() {
        contentView.addSubview(subView)
        subView.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(10)
            make.bottom.trailing.equalToSuperview().inset(10)
        }
        subView.backgroundColor = .lightGray
        subView.cornerRadius = 15
    }
    
    private func setWritenBy() {
        subView.addSubview(writenByLabel)
        writenByLabel.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().inset(5)
        }
        writenByLabel.font = .boldSystemFont(ofSize: 15)
        writenByLabel.textColor = .black
        writenByLabel.textAlignment = .left
    }
    
    private func setStackView() {
        subView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(writenByLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(5)
            make.trailing.bottom.equalToSuperview().inset(5)
        }
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .fill
        stackView.spacing = 20
    }
    
    private func setLeftImageView() {
        stackView.addArrangedSubview(leftImageView)
        leftImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(40)
        }
        leftImageView.makeRoundWithBorder(borderColor: .black, borderWidth: 3, cornerRadius: 20)
        leftImageView.contentMode = .scaleAspectFit
        leftImageView.image = UIImage(named: "avatar")
    }
    
    private func setMessageBubble() {
        stackView.addArrangedSubview(messageBubble)
        messageBubble.backgroundColor = .orange
        messageBubble.cornerRadius = 15
        messageBubble.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(10)
            make.trailing.bottom.equalToSuperview().inset(10)
        }
        messageLabel.textAlignment = .left
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.font = .systemFont(ofSize: 15)
    }
    
    private func setRightImageView() {
        stackView.addArrangedSubview(rightImageView)
        rightImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(40)
        }
        rightImageView.makeRoundWithBorder(borderColor: .black, borderWidth: 3, cornerRadius: 20)
        rightImageView.contentMode = .scaleAspectFit
        rightImageView.image = UIImage(named: "avatar")
    }
    
    
    
}
