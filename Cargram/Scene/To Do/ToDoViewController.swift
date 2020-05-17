//
//  ToDoViewController.swift
//  Cargram
//
//  Created by Ferhan Akkan on 15.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//


import UIKit
import PromiseKit


final class ToDoViewController: BaseViewController {
        
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5)
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 200)
        let collectionview = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0 ), collectionViewLayout: layout)
        collectionview.backgroundColor = .clear
        collectionview.register(ToDoCollectionViewCell.self, forCellWithReuseIdentifier: "ToDoCollectionViewCell")
        collectionview.register(ToDoNonCollectionViewCell.self, forCellWithReuseIdentifier: "ToDoNonCollectionViewCell")
        return collectionview
    }()
    
    let toDoViewModel = ToDoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        toDoViewModel.fetchData { (_) in
            self.collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newTitleButtonPressed))
    }
    
    @objc private func newTitleButtonPressed() {
        let vc = ToDoCreateViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.toDoCreateViewModel.delegate = self
        present(vc,animated: true)
    }
}

//MARK: - Setup UI

extension ToDoViewController {
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
extension ToDoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return toDoViewModel.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return toDoViewModel.setCollectionViewCell(owner: self, indexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         collectionView.deselectItem(at: indexPath, animated: true)
        if toDoViewModel.todoArray.count != 0 {
            let vc = toDoViewModel.setSelectedRow(indexPath: indexPath.row)
            vc.toDoDetailViewModel.delegate = self
            navigationController?.show(vc, sender: nil)
        }
     }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width-10, height: view.frame.height/3)
    }
}

//MARK: - To Do Data Added && Remove

extension ToDoViewController: ToDoCreated, DidToDoChanged {
    func toDoChanged() {
        toDoViewModel.fetchData { (_) in
            self.collectionView.reloadData()
        }
    }
    
    func todoCreated() {
        toDoViewModel.fetchData { (_) in
            self.collectionView.reloadData()
        }
    }

}
