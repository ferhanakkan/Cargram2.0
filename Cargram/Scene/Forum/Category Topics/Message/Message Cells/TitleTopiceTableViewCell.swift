//
//  TitleTopiceTableViewCell.swift
//  Cargram
//
//  Created by Ferhan Akkan on 15.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit

class TitleTopiceTableViewCell: UITableViewCell {
    
    let subView = UIView()
    let avatarImage = UIImageView()
    let askedByLabel = UILabel()
    let questionLabel = UILabel()
    let questionDescriptionLabel = UILabel()
    
    let firebase = FirebaseImageService()
    
    var message: MessageModel? = nil {
        didSet{
            askedByLabel.text = "Asked By: \(message!.username)"
            questionLabel.text = message!.title
            questionDescriptionLabel.text = message!.subtitle
            if message!.username == "Anonymous" {
                avatarImage.image = UIImage(named: "avatar")
            } else {
                firebase.getOtherUsersImage(username: message!.username) { (data) in
                    self.avatarImage.image = UIImage(data: data)
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

extension TitleTopiceTableViewCell {
    
    private func setUI() {
        contentView.backgroundColor = .clear
        setSubView()
        setAvatar()
        setAskedBy()
        setQuestion()
        setQuestionDescription()
    }
    
    private func setSubView() {
        contentView.addSubview(subView)
        subView.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(5)
            make.trailing.bottom.equalToSuperview().inset(5)
            make.height.greaterThanOrEqualTo(120)
        }
        subView.backgroundColor = .white
    }
    
    private func setAvatar() {
        subView.addSubview(avatarImage)
        avatarImage.snp.makeConstraints { (make) in
            make.height.width.equalTo(100)
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        avatarImage.makeRoundWithBorder(borderColor: .black, borderWidth: 3, cornerRadius: 50)
    }
    
    private func setAskedBy() {
        subView.addSubview(askedByLabel)
        askedByLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.leading.equalTo(avatarImage.snp.trailing).offset(10)
        }
        askedByLabel.textColor = .black
        askedByLabel.font = .boldSystemFont(ofSize: 25)
        askedByLabel.textAlignment = .left
    }
    
    private func setQuestion() {
        subView.addSubview(questionLabel)
        questionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(askedByLabel.snp.bottom).offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.leading.equalTo(avatarImage.snp.trailing).offset(10)
        }
        questionLabel.textColor = .black
        questionLabel.font = .systemFont(ofSize: 15)
        questionLabel.textAlignment = .left
    }
    
    private func setQuestionDescription() {
        subView.addSubview(questionDescriptionLabel)
        questionDescriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(questionLabel.snp.bottom).offset(10)
            make.trailing.bottom.equalToSuperview().inset(10)
            make.leading.equalTo(avatarImage.snp.trailing).offset(10)
        }
        questionDescriptionLabel.textColor = .black
        questionDescriptionLabel.font = .systemFont(ofSize: 10)
        questionDescriptionLabel.textAlignment = .left
    }
    
}
