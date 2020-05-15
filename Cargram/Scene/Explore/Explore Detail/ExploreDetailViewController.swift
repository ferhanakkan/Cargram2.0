//
//  ExploreDetailViewController.swift
//  Cargram
//
//  Created by Ferhan Akkan on 14.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit

final class ExploreDetailViewController: UIViewController {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5)
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width-10, height: 1)
        let collectionview = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0 ), collectionViewLayout: layout)
        collectionview.backgroundColor = .clear
        collectionview.register(ExploreDetailCollectionViewCell.self, forCellWithReuseIdentifier: "ExploreDetailCollectionViewCell")
        collectionview.register(ExploreDetailTitleCollectionViewCell.self, forCellWithReuseIdentifier: "ExploreDetailTitleCollectionViewCell")
        collectionview.register(ExploreDetailVideoCollectionViewCell.self, forCellWithReuseIdentifier: "ExploreDetailVideoCollectionViewCell")
        return collectionview
    }()

    let exploreDetailViewModel = ExploreDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        fetchData()
    }
}

//MARK: - Setup UI
extension ExploreDetailViewController {
    private func setUI() {
        view.backgroundColor = .white
        setColletionView()
    }
    
    private func setColletionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

//MARK: - CollectionView DataSource & Delegate

extension ExploreDetailViewController: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = exploreDetailViewModel.exploreDetailArray?.count {
            return count+1
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreDetailTitleCollectionViewCell", for: indexPath) as! ExploreDetailTitleCollectionViewCell
            cell.title.text = exploreDetailViewModel.titleData?.title
            DispatchQueue.main.async {
                cell.image.kf.setImage(with: self.exploreDetailViewModel.titleData!.image)
            }
            return cell
            
        } else if exploreDetailViewModel.exploreDetailArray![indexPath.row-1].title == "Video" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreDetailVideoCollectionViewCell", for: indexPath) as! ExploreDetailVideoCollectionViewCell
            cell.url = exploreDetailViewModel.exploreDetailArray![indexPath.row-1].imageUrl.absoluteString
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreDetailCollectionViewCell", for: indexPath) as! ExploreDetailCollectionViewCell
            cell.title.text = exploreDetailViewModel.exploreDetailArray![indexPath.row-1].title.replacingOccurrences(of: "\\n", with: "\n")
            DispatchQueue.main.async {
                cell.image.kf.setImage(with: self.exploreDetailViewModel.exploreDetailArray![indexPath.row-1].imageUrl)
            }
            return cell
        }
    }
}

extension ExploreDetailViewController {
    private func fetchData() {
        LoadingView.show()
        exploreDetailViewModel.fetchData { (_) in
            self.collectionView.reloadData()
            LoadingView.hide()
        }
    }
}
