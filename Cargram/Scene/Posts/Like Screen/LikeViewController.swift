//
//  LikeViewController.swift
//  Cargram
//
//  Created by Ferhan Akkan on 21.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

final class LikeViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.backgroundColor = .white
        tableView.register(LikeTableViewCell.self, forCellReuseIdentifier: "LikeTableViewCell")
        return tableView
    }()
    
    let likeViewModel = LikeViewModel()
    weak var delegate: LikeDeleted?
    let topView = UIView()
    let doneButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}

//MARK: - Setup UI

extension LikeViewController {
    private func setUI() {
        view.backgroundColor = .white
        setDoneButton()
        setTableView()
    }
    
    private func setDoneButton() {
        view.addSubview(topView)
        topView.backgroundColor = .gray
        topView.snp.makeConstraints { (make) in
            make.height.equalTo(60)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        topView.addSubview(doneButton)
        doneButton.setTitle("Done", for: .normal)
        doneButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        doneButton.setTitleColor(.orange, for: .normal)
        doneButton.isUserInteractionEnabled = true
        doneButton.addTarget(self, action: #selector(donePressed), for: .touchUpInside)
        
        doneButton.snp.makeConstraints({ (make) in
            make.height.width.equalTo(50)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
            
        })
    }
    
    private func setTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(topView.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        tableView.dataSource = self
        tableView.delegate = self
    }
}

//MARK: - TableView Delegate & Datasource

extension LikeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likeViewModel.likeArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LikeTableViewCell", for: indexPath) as! LikeTableViewCell
        let selectedObject = likeViewModel.likeArray![indexPath.row]
        cell.profileImageView.image = nil
        cell.profileImageView.kf.setImage(with: URL(string: selectedObject.imageUrl))
        cell.usernameLabel.text = selectedObject.sender
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let isPossableDelete = likeViewModel.likeArray![indexPath.row].sender == Auth.auth().currentUser!.displayName!
        return isPossableDelete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let selectedObject = likeViewModel.likeArray![indexPath.row]
        if editingStyle == .delete {
            
            let firestoreDatabase = Firestore.firestore()
            firestoreDatabase.collection("Posts").document(selectedObject.postID).collection("Like").document(selectedObject.likeID).delete() { err in
                if let err = err {
                   print(err)
                } else {
                    self.delegate?.likeDataDeleted()
                    self.likeViewModel.likeArray?.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .bottom)
                }
            }
        }
    }
}

//MARK: - Actions

extension LikeViewController {
    @objc func donePressed() {
      dismiss(animated: true, completion: nil)
    }
}


//MARK: - Protocol Like Delete

protocol LikeDeleted: AnyObject {
    func likeDataDeleted()
}
