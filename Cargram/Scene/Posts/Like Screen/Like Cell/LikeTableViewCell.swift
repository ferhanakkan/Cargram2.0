//
//  LikeTableViewCell.swift
//  Cargram
//
//  Created by Ferhan Akkan on 21.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit

class LikeTableViewCell: UITableViewCell {
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Setup UI

extension LikeTableViewCell {
    
    private func setUI() {
        contentView.backgroundColor = .white
        contentView.snp.makeConstraints { (make) in
            make.height.greaterThanOrEqualTo(70)
            make.width.equalToSuperview()
        }
        setImageView()
        setUserLabel()
    }
    
    private func setImageView() {
        contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.leading.equalToSuperview().offset(10)
            make.top.greaterThanOrEqualToSuperview().offset(10)
            make.bottom.greaterThanOrEqualToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setUserLabel() {
        contentView.addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.centerY.equalTo(profileImageView.snp.centerY)
            make.trailing.equalToSuperview().inset(10)
        }
    }
}
