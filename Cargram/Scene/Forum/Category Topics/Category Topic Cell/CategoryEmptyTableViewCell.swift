//
//  CategoryEmptyTableViewCell.swift
//  Cargram
//
//  Created by Ferhan Akkan on 15.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import Foundation


import UIKit
import SnapKit

class CategoryEmptyTableViewCell: UITableViewCell {
    
    let title = UILabel()
    let subView = UIView()
    let sembolImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}

//MARK: - Setup UI

extension CategoryEmptyTableViewCell {
    private func setUI() {
        contentView.backgroundColor = .white
        setSubView()
        setTitle()
        setImage()
    }
    
    private func setSubView() {
        contentView.addSubview(subView)
        subView.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(10)
            make.height.equalTo(UIScreen.main.bounds.height/3)
            make.bottom.trailing.equalToSuperview().inset(10)
        }
        subView.backgroundColor = .gray
        subView.shadowAndCorner(radius: 15, shadowRadius: 15, opacity: 0.6, color: .black, width: 3, height: 3)
    }
    
    private func setTitle() {
        subView.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        title.numberOfLines = 0
        title.textAlignment = .left
        title.font = UIFont.boldSystemFont(ofSize: 20)
        title.text = "There isn't any created topic"
    }
    
    private func setImage() {
        subView.addSubview(sembolImage)
        sembolImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.height.width.equalTo(80)
            make.centerX.equalToSuperview()
        }
        sembolImage.image = UIImage(named: "nonTopic")
    }
}
