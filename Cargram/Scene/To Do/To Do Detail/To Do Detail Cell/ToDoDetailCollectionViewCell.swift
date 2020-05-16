//
//  ToDoDetailCollectionViewCell.swift
//  Cargram
//
//  Created by Ferhan Akkan on 16.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit

final class ToDoDetailCollectionViewCell: UICollectionViewCell {
    
    let button: UIButton = {
        let button = UIButton()
        button.imageView!.image = UIImage(named: "avatar")
        button.backgroundColor = .gray
        return button
    }()
    
    var selectedRow: Int? = nil
    var delegate: DetailSelectedImageShow?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.cornerRadius = 15
        contentView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.bottom.top.leading.trailing.equalToSuperview()
        }
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc private func buttonPressed() {
        delegate?.showImage(selectedImage: selectedRow!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol DetailSelectedImageShow {
    func showImage(selectedImage: Int)
}
