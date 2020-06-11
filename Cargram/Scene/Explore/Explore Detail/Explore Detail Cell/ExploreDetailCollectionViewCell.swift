//
//  ExploreDetailCollectionViewCell.swift
//  Cargram
//
//  Created by Ferhan Akkan on 14.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit

final class ExploreDetailCollectionViewCell: UICollectionViewCell {
    
    let image: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 15
        return view
    }()
    
    let title: UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 15)
        title.textColor = .black
        title.numberOfLines = 0
        return title
    }()
    
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: bounds.size.height))
    }


    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(image)
        contentView.addSubview(title)
        
        image.snp.makeConstraints { (make) in
            make.height.equalTo(200)
            make.top.leading.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        title.snp.makeConstraints { (make) in
            make.height.greaterThanOrEqualTo(30)
            make.leading.equalToSuperview().offset(30)
            make.trailing.bottom.equalToSuperview().offset(-30)
            make.top.equalTo(image.snp.bottom).offset(30)
        }
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
