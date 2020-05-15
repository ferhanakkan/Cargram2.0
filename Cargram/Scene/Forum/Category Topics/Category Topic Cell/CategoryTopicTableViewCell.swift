//
//  CategoryTopicTableViewCell.swift
//  Cargram
//
//  Created by Ferhan Akkan on 15.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit

class CategoryTopicTableViewCell: UITableViewCell {
    
    let title = UILabel()
    let subTitle = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}

//MARK: - Setup UI

extension CategoryTopicTableViewCell {
    private func setUI() {
        contentView.backgroundColor = .white
        setTitle()
        setSubTitle()
    }
    
    private func setTitle() {
        contentView.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.leading.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(30)
        }
        title.numberOfLines = 0
        title.textAlignment = .left
        title.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    private func setSubTitle() {
        contentView.addSubview(subTitle)
        subTitle.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(10)
        }
        subTitle.numberOfLines = 0
        subTitle.textAlignment = .left
        subTitle.font = UIFont.systemFont(ofSize: 15)
    }
}
