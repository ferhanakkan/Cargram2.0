//
//  CommitTableViewCell.swift
//  Cargram
//
//  Created by Ferhan Akkan on 21.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//


import UIKit
import SnapKit

class CommitTableViewCell: UITableViewCell {
    
    let profileImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.makeRoundWithBorder(borderColor: .black, borderWidth: 1, cornerRadius: 25)
        return image
    }()
    
    let usernameLabel: UILabel = {
        let title = UILabel()
        title.textAlignment = .left
        title.font = UIFont.boldSystemFont(ofSize: 15)
        title.textColor = .black
        title.numberOfLines = 1
        return title
    }()
    
    let commitLabel: UILabel = {
        let title = UILabel()
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 10)
        title.textColor = .black
        title.numberOfLines = 0
        return title
    }()
    
    var commitObject: CommitModel? {
        didSet {
            usernameLabel.text = commitObject!.sender
            commitLabel.text = commitObject!.commit
            profileImageView.kf.setImage(with: URL(string: (commitObject?.imageUrl)!))
            setUI()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Setup UI

extension CommitTableViewCell {
    
    private func setUI() {
        contentView.backgroundColor = .white
        setImageView()
        setUserLabel()
        setCommitLabel()
    }
    
    private func setImageView() {
        contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.top.greaterThanOrEqualToSuperview().offset(10)
            make.bottom.lessThanOrEqualToSuperview().inset(10)
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setUserLabel() {
        contentView.addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(20)
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    private func setCommitLabel() {
        contentView.addSubview(commitLabel)
        commitLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.top.equalTo(usernameLabel.snp.bottom).offset(5)
            make.trailing.bottom.equalToSuperview().inset(10)
        }
    }
}
