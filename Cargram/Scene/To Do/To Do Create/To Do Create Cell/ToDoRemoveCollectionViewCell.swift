//
//  ToDoRemoveCollectionViewCell.swift
//  Cargram
//
//  Created by Ferhan Akkan on 15.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit

final class ToDoRemoveCollectionViewCell: UICollectionViewCell {
    
    let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        return button
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        return button
    }()
    
    var delegate: ImageRemoveProtocol?
    var detailDelegate: ImageDetailShow?
    var selectedIndex: Int?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.cornerRadius = 15
        contentView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.bottom.top.leading.trailing.equalToSuperview()
        }
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        button.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().inset(5)
            make.height.width.equalTo(26)
        }
        
        deleteButton.layer.cornerRadius = 13
        deleteButton.addTarget(self, action: #selector(deletePressed), for: .touchUpInside)
    }
    
    @objc private func buttonPressed() {
        detailDelegate?.imageProtocolShow(selectedCell: selectedIndex!)
    }
    
    @objc private func deletePressed() {
        delegate?.imageProtocolRemove(selectedCell: selectedIndex!)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
