//
//  ToDoNonCollectionViewCell.swift
//  Cargram
//
//  Created by Ferhan Akkan on 16.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit

final class ToDoNonCollectionViewCell: UICollectionViewCell {
    
    let image: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "arrow")
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 15
        return view
    }()
    
    let title: UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        title.textAlignment = .left
        title.font = UIFont.boldSystemFont(ofSize: 30)
        title.textColor = .white
        title.text = "You don't have any plan, do you want to create one ?"
        return title
    }()
    

    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.cornerRadius = 15
        contentView.addSubview(image)
        contentView.addSubview(title)
        contentView.backgroundColor = .gray
        
        image.snp.makeConstraints { (make) in
            make.height.width.equalTo(40)
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
        }
        
        title.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
