//
//  PostsViewController.swift
//  Cargram
//
//  Created by Ferhan Akkan on 19.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.

import UIKit
import SnapKit

final class FlowCollectionViewController: BaseViewController {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.4)
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let collectionview = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0 ), collectionViewLayout: layout)
        collectionview.backgroundColor = .clear
        collectionview.showsVerticalScrollIndicator = false
        collectionview.showsHorizontalScrollIndicator = false
        collectionview.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: "PostCollectionViewCell")
        collectionview.register(LoadingCollectionViewCell.self, forCellWithReuseIdentifier: "LoadingCollectionViewCell")
        return collectionview
    }()
    
    let flowViewModel = FlowViewModel()
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        flowViewModel.delegate = self
        LoadingView.show()
        flowViewModel.beginBatchFetch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newPost))
    }
    
    @objc private func newPost() {
        let vc = NewPostViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.delegate = self
        navigationController?.show(vc, sender: nil)
    }
}

//MARK: - Setup UI

extension FlowCollectionViewController {
    private func setUI() {
        view.backgroundColor = .white
        setCollectionView()
        setRefreshControl()
    }
    
    private func setCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

//MARK: - CollectionView DataSource & Delegate
extension FlowCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return flowViewModel.postData.count
        case 1:
            return (flowViewModel.fetchingMore && !flowViewModel.endReached) ? 1 : 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as! PostCollectionViewCell
            cell.postModel = nil
            cell.postModel = flowViewModel.postData[indexPath.row]
            cell.delegate = self
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoadingCollectionViewCell", for: indexPath) as! LoadingCollectionViewCell
            cell.spinner.startAnimating()
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height {
            flowViewModel.scrollDidEnd()
        }
    }
}

//MARK: - Did Fetch End Delegate
extension FlowCollectionViewController: FetchingDidEnd, PostDeleteAction {
    
    func postDeleted() {
        flowViewModel.refreshControl { [unowned self] (_) in
            self.refreshControl.endRefreshing()
            self.collectionView.reloadData()
        }
    }
    
    func fetchDidEnd() {
        UIView.performWithoutAnimation {
            collectionView.reloadData()
        }
    }
}

//MARK: - Refresh Control

extension FlowCollectionViewController {
    
    func setRefreshControl() {
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    }
    
    @objc func handleRefresh() {
        flowViewModel.refreshControl { [unowned self] (_) in
            self.refreshControl.endRefreshing()
            self.collectionView.reloadData()
        }
    }
}

//MARK: - New Post Delegate

extension FlowCollectionViewController: NewPost {
    func newPostAdded() {
        flowViewModel.refreshControl { [unowned self] (_) in
            self.refreshControl.endRefreshing()
            self.collectionView.reloadData()
        }
    }
}
