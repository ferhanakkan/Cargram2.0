//
//  ForumCategoryTableViewCell.swift
//  Cargram
//
//  Created by Ferhan Akkan on 14.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit

class ForumCategoryTableViewCell: UITableViewCell {
    
    let categoryImageView = UIImageView()
    let title = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}

//MARK: - Setup UI

extension ForumCategoryTableViewCell {
    private func setUI() {
        contentView.backgroundColor = .white
        setImageView()
        setTitle()
    }
    
    private func setImageView() {
        contentView.addSubview(categoryImageView)
        categoryImageView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.height.width.equalTo(60)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        categoryImageView.contentMode = .scaleToFill
    }
    
    private func setTitle() {
        contentView.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.leading.equalTo(categoryImageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        title.numberOfLines = 0
        title.textAlignment = .left
        title.font = UIFont.boldSystemFont(ofSize: 20)
    }
}
