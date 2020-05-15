//
//  ExploreDetailVideoCollectionViewCell.swift
//  Cargram
//
//  Created by Ferhan Akkan on 14.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import WebKit

final class ExploreDetailVideoCollectionViewCell: UICollectionViewCell {
    
    let videoView: WKWebView = {
        return WKWebView()
    }()
    
    var url: String = "" {
        didSet {
            videoView.load(URLRequest(url:URL(string:  "https://www.youtube.com/embed/\(url)")!))
        }
    }
    
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
        contentView.addSubview(videoView)
        
        videoView.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height/3)
        }
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
}
