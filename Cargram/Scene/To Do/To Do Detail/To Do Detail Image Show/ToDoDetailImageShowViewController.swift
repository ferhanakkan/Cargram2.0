//
//  ToDoDetailImageShowViewController.swift
//  Cargram
//
//  Created by Ferhan Akkan on 15.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit

class ToDoDetailImageShowViewController : UIViewController {
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+40000)
    
    lazy var toDoDetailViewModel = ToDoDetailViewModel()

    let scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.backgroundColor = .black
        return scroll
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .black
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}

//MARK: - Setup UI

extension ToDoDetailImageShowViewController {
    
    private func setUI() {
        scrollView.maximumZoomScale = 4
        scrollView.minimumZoomScale = 1
        scrollView.delegate = self
        scrollView.contentSize = contentViewSize
        view.backgroundColor = .black
        view.addSubview(scrollView)
        setScrollView()
    }
    
    private func setScrollView() {
        scrollView.addSubview(imageView)
        scrollView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalToSuperview()
            make.width.equalTo(self.view.snp.width)
            make.height.equalTo(self.scrollView.snp.height)
        }
    }
}

//MARK: - ScrollView Delegate

extension ToDoDetailImageShowViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 1 {
            if let image = imageView.image {
                let ratioW = imageView.frame.width / image.size.width
                let ratioH = imageView.frame.height / image.size.height
                
                let ratio = ratioW < ratioH ? ratioW : ratioH
                let newWidth = image.size.width * ratio
                let newHeight = image.size.height * ratio
                let conditionLeft = newWidth*scrollView.zoomScale > imageView.frame.width
                let left = 0.5 * (conditionLeft ? newWidth - imageView.frame.width : (scrollView.frame.width - scrollView.contentSize.width))
                let conditioTop = newHeight*scrollView.zoomScale > imageView.frame.height
                
                let top = 0.5 * (conditioTop ? newHeight - imageView.frame.height : (scrollView.frame.height - scrollView.contentSize.height))
                
                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
                
            }
        } else {
            scrollView.contentInset = .zero
        }
    }
}



