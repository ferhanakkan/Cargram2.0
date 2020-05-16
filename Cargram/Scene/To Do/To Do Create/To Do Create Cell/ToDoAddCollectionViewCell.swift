//
//  ToDoAddCollectionViewCell.swift
//  Cargram
//
//  Created by Ferhan Akkan on 15.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit

final class ToDoAddCollectionViewCell: UICollectionViewCell {
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        return button
    }()
    
    var delegate: ImageAddProtocol?
    
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
        delegate?.imageProtocolAdd()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
