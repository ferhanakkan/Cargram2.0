//
//  EndedEventTableViewCell.swift
//  Cargram
//
//  Created by Ferhan Akkan on 4.06.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit

class EndedEventTableViewCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.textAlignment = .left
        title.font = UIFont.boldSystemFont(ofSize: 25)
        title.textColor = .black
        title.numberOfLines = 0
        return title
    }()
    
    let descriptionLabel: UILabel = {
        let title = UILabel()
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 20)
        title.textColor = .black
        title.numberOfLines = 0
        return title
    }()
    
    let endLabel: UILabel = {
        let title = UILabel()
        title.textAlignment = .left
        title.font = UIFont.boldSystemFont(ofSize: 20)
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

extension EndedEventTableViewCell {
    
    private func setUI() {
        contentView.backgroundColor = .white
        setTitleLabel()
        setDescriptionLabel()
        setEndLabel()
    }
    
    private func setTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(30)
            make.top.equalToSuperview().offset(10)
        }
    }
    
    private func setDescriptionLabel() {
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(30)
            make.top.equalTo(titleLabel.snp.bottom)
        }
    }
    
    private func setEndLabel() {
        contentView.addSubview(endLabel)
        endLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(30)
            make.top.equalTo(descriptionLabel.snp.bottom)
            make.bottom.equalToSuperview().inset(10)
            make.height.equalTo(30)
        }
    }
}
