//
//  ExploreViewController.swift
//  Cargram
//
//  Created by Ferhan Akkan on 14.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import PromiseKit


final class ExploreViewController: BaseViewController {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5)
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 200)
        let collectionview = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0 ), collectionViewLayout: layout)
        collectionview.backgroundColor = .clear
        collectionview.register(ExploreCollectionViewCell.self, forCellWithReuseIdentifier: "ExploreCollectionViewCell")
        return collectionview
    }()
    
    let exploreViewModel = ExploreViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        fetchData()
    }
}

//MARK: - Service

extension ExploreViewController {
    private func fetchData() {
        LoadingView.show()
        exploreViewModel.fetchExploreData { (_) in
            self.collectionView.reloadData()
            LoadingView.hide()
        }
    }
}

//MARK: - Setup UI

extension ExploreViewController {
    private func setUI() {
        view.backgroundColor = .white
        setCollectionView()
    }
    
    private func setCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

//MARK: - CollectionView DataSource & Delegate
extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exploreViewModel.exploreArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreCollectionViewCell", for: indexPath) as! ExploreCollectionViewCell
        cell.image.kf.setImage(with: self.exploreViewModel.exploreArray[indexPath.row].image)
        cell.title.text = self.exploreViewModel.exploreArray[indexPath.row].title
        cell.subTitle.text = self.exploreViewModel.exploreArray[indexPath.row].subtitle
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         collectionView.deselectItem(at: indexPath, animated: true)
         let vc = exploreViewModel.setSelectedRow(indexPath: indexPath.row)
         navigationController?.show(vc, sender: nil)
     }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width-10, height: view.frame.height/3)
    }
}
