//
//  ToDoDetailViewController.swift
//  Cargram
//
//  Created by Ferhan Akkan on 15.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit

class ToDoDetailViewController : UIViewController {
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+40000)
    
    lazy var toDoDetailViewModel = ToDoDetailViewModel()

    let scroolView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.backgroundColor = .white
        return scroll
    }()
    
    let conteiner: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let image: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "avatar")
       return image
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 25.0)
        title.numberOfLines = 0
        return title
    }()
    
    let descriptionLabel: UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        return title
    }()
    
    let endTimeLabel: UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        title.font = .boldSystemFont(ofSize: 15)
        return title
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 200)
        let collectionview = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0 ), collectionViewLayout: layout)
        collectionview.backgroundColor = .clear
        collectionview.register(ToDoDetailCollectionViewCell.self, forCellWithReuseIdentifier: "ToDoDetailCollectionViewCell")
        return collectionview
    }()
    
    let completeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Complete", for: .normal)
        button.titleLabel!.font = .boldSystemFont(ofSize: 15)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.cornerRadius = 15
        return button
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete", for: .normal)
        button.titleLabel!.font = .boldSystemFont(ofSize: 15)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.cornerRadius = 15
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        DispatchQueue.main.async {
            self.setDatas()
        }
    }
    
    func setDatas() {
        let object = toDoDetailViewModel.toDoSelectedArray
        image.image = UIImage(data: object!.picArray[0])
        titleLabel.text = object!.toDoTitle
        descriptionLabel.text = object!.toDoDescription
        if object!.toDoDateShow {
            let text = toDoDetailViewModel.setDatas()
            endTimeLabel.text = "Deadline: \(text)"
            
        } else {
            endTimeLabel.isHidden = true
        }
        
        object!.toDoCompletted ? (completeButton.setTitle("Set Uncompleted", for: .normal)) : (completeButton.setTitle("Set Completed", for: .normal))
    }
    

}

//MARK: - Setup UI

extension ToDoDetailViewController {
    
    private func setUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        scroolView.contentSize = contentViewSize
        view.backgroundColor = .white
        view.addSubview(scroolView)
        setScrollView()
        setImage()
        setTitle()
        setDescription()
        setTime()
        setCollectionView()
        setCompleteButton()
        setDeleteButton()
    }
    
    private func setScrollView() {
        scroolView.addSubview(conteiner)
        scroolView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        conteiner.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalToSuperview()
            make.width.equalTo(self.view.snp.width)
        }
    }
    
    private func setImage() {
        conteiner.addSubview(image)
        image.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height/3)
        }
    }
    
    private func setTitle() {
        conteiner.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(image.snp.bottom).offset(20)
        }
    }
    
    private func setDescription() {
        conteiner.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
    }
    
    private func setTime() {
        conteiner.addSubview(endTimeLabel)
        
        endTimeLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
        }
    }
    
    private func setCollectionView() {
        conteiner.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(endTimeLabel.snp.bottom).offset(20)
            make.height.equalTo(100)
        }
    }
    
    private func setCompleteButton() {
        conteiner.addSubview(completeButton)
        
        completeButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.collectionView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        completeButton.addTarget(self, action: #selector(completePressed), for: .touchUpInside)
    }
    
    private func setDeleteButton() {
        conteiner.addSubview(deleteButton)
        
        deleteButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.completeButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        deleteButton.addTarget(self, action: #selector(deletePressed), for: .touchUpInside)
    }

}
//MARK: - Actions

extension ToDoDetailViewController {
    
    @objc func deletePressed() {
        toDoDetailViewModel.deleteSelectedPlanFromDatabase()
        navigationController?.popViewController(animated: true)
    }
    
    @objc func completePressed() {
        toDoDetailViewModel.completeSelectedPlanFromDatabase()
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - CollectionView Delegate & DataSource

extension ToDoDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return toDoDetailViewModel.toDoSelectedArray!.picArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ToDoDetailCollectionViewCell", for: indexPath) as! ToDoDetailCollectionViewCell
        let picData = toDoDetailViewModel.toDoSelectedArray!.picArray[indexPath.row]
        cell.button.setImage(UIImage(data: picData), for: .normal)
        cell.selectedRow = indexPath.row
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height-10,height: collectionView.frame.height-10)
    }
}

//MARK: - Selected Image Show Protocol

extension ToDoDetailViewController: DetailSelectedImageShow {    
    func showImage(selectedImage: Int) {
        let vc = ToDoDetailImageShowViewController()
        let data = toDoDetailViewModel.toDoSelectedArray!.picArray[selectedImage]
        vc.imageView.image = UIImage(data: data)
        navigationController?.show(vc, sender: nil)
    }
}

