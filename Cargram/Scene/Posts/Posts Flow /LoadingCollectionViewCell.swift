//
//  LoadingCollectionViewCell.swift
//  Cargram
//
//  Created by Ferhan Akkan on 25.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit

class LoadingCollectionViewCell: UICollectionViewCell {
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.addSubview(spinner)
        contentView.snp.makeConstraints { (make) in
            make.height.equalTo(60)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        spinner.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
