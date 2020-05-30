//
//  CommitViewController.swift
//  Cargram
//
//  Created by Ferhan Akkan on 21.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

final class CommitViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.backgroundColor = .white
        tableView.register(CommitTableViewCell.self, forCellReuseIdentifier: "CommitTableViewCell")
        return tableView
    }()
    
    let commitViewModel = CommitViewModel()
    weak var delegate: CommitDeleted?
    let topView = UIView()
    let doneButton = UIButton()
    let customView = UIView()
    let viewSafe = UIView()
    let sendButton = UIButton()
    let messageTextfield = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}

//MARK: - Setup UI

extension CommitViewController {
    private func setUI() {
        view.backgroundColor = .white
        setDoneButton()
        setTableView()
        setSenderView()
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
        }
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setSenderView() {
        
        customView.backgroundColor = .backgroundGreen
        view.addSubview(customView)
        
        customView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(65)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.top.equalTo(self.tableView.snp.bottom)
        }
        
        
        customView.addSubview(sendButton)
        sendButton.setImage(UIImage(named: "plane"), for: .normal)
        sendButton.isUserInteractionEnabled = true
        sendButton.addTarget(self, action: #selector(sendPressed), for: .touchUpInside)
        
        sendButton.snp.makeConstraints({ (make) in
            make.height.width.equalTo(30)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
            
        })
        
        
        customView.addSubview(messageTextfield)
        messageTextfield.placeholder = "Type Message"
        messageTextfield.borderStyle = .roundedRect
        
        messageTextfield.snp.makeConstraints({ (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(70)
            make.bottom.equalToSuperview().inset(5)
            make.top.equalToSuperview().offset(5)
        })
        
        viewSafe.backgroundColor = .backgroundGreen
        view.addSubview(viewSafe)
        
        viewSafe.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.trailing.leading.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

//MARK: - TableView Delegate & Datasource

extension CommitViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {        return commitViewModel.commitArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CommitTableViewCell", for: indexPath) as! CommitTableViewCell
        cell.commitObject = commitViewModel.commitArray![indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let isPossableDelete = commitViewModel.commitArray![indexPath.row].sender == Auth.auth().currentUser!.displayName!
        return isPossableDelete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         let selectedObject = commitViewModel.commitArray![indexPath.row]

        if editingStyle == .delete  {
            
            let firestoreDatabase = Firestore.firestore()
            firestoreDatabase.collection("Posts").document(selectedObject.postID).collection("Commit").document(selectedObject.commitID).delete() { err in
                if let err = err {
                   print(err)
                } else {
                    self.delegate?.commitDataDeleted()
                    self.commitViewModel.commitArray!.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .bottom)
                }
            }
        }
    }
}

//MARK: - Actions

extension CommitViewController {
    @objc func sendPressed() {
        commitViewModel.sendCommit(commit: messageTextfield.text!) {
            self.delegate?.commitDataDeleted()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func donePressed() {
      dismiss(animated: true, completion: nil)
    }
}


//MARK: - Protocol Like Delete

protocol CommitDeleted: AnyObject {
    func commitDataDeleted()
}
