//
//  AuthViewController.swift
//  Cargram
//
//  Created by Ferhan Akkan on 11.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit

class AuthViewController: UIViewController {
    
    //MARK: - Properties
    
    let backgroundView = UIView()
    let imageView = UIImageView()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionview = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0 ), collectionViewLayout: layout)
        collectionview.backgroundColor = .clear
        collectionview.isPagingEnabled = true
        collectionview.isScrollEnabled = false
        collectionview.register(RegisterColletionViewCell.self, forCellWithReuseIdentifier: "RegisterColletionViewCell")
        collectionview.register(LogInColletionViewCell.self, forCellWithReuseIdentifier: "LogInColletionViewCell")
        collectionview.register(ForgotColletionViewCell.self, forCellWithReuseIdentifier: "ForgotColletionViewCell")
        return collectionview
    }()
    
    let authViewModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setBackgroundView()
        setImageView()
        setCollectionView()
    }
}

    //MARK: - Setup UI
extension AuthViewController {
    
    private func setView() {
        view.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setBackgroundView() {
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(view.frame.height*0.6)
        }
        backgroundView.roundCornersEachCorner([.bottomLeft, .bottomRight], radius: 20)
        backgroundView.backgroundColor = .gray
    }
    
    private func setImageView() {
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(70)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
        }
        imageView.image = #imageLiteral(resourceName: "alert")
    }
    
    private func setCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
        }
    }
}

    //MARK: - CollectionView Delegate & Datasource

extension AuthViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CollectionViewIndexSelector {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return authViewModel.collectionViewCell(indexPath: indexPath, owner: self)
    }
    
    func selectedCollectionViewIndex(row: Int) {
        let index = IndexPath(row: row, section: 0)
        collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }
}
