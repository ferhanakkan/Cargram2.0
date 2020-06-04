//
//  MessageViewController.swift
//  Cargram
//
//  Created by Ferhan Akkan on 15.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

final class MessageViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.backgroundColor = .white
        tableView.register(TitleTopiceTableViewCell.self, forCellReuseIdentifier: "TitleTopiceTableViewCell")
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: "MessageTableViewCell")
        return tableView
    }()
    let customView = UIView()
    let viewSafe = UIView()
    let sendButton = UIButton()
    let messageTextfield = UITextField()
    
    let messaegeViewModel = MessageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        messaegeViewModel.getMessage()
    }
}

//MARK: - Setup UI

extension MessageViewController {
    private func setUI() {
        view.backgroundColor = .white
        messaegeViewModel.firebase.delegate = self
        setSenderView()
        setTableView()
    }
    
    private func setTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(customView.snp.top)
        }
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    internal func setSenderView() {
        
        customView.backgroundColor = .gray
        view.addSubview(customView)
        
        customView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(65)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
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
        
        viewSafe.backgroundColor = .gray
        view.addSubview(viewSafe)
        
        viewSafe.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.trailing.leading.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

//MARK: - TableView Delegate & Datasource

extension MessageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return messaegeViewModel.messageModel.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messaegeViewModel.messageModel[indexPath.section]
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTopiceTableViewCell", for: indexPath) as! TitleTopiceTableViewCell
            cell.message = message
            return cell

        default:
            let cell =  tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as! MessageTableViewCell
            cell.message = message
            return cell
        }
    }
}

//MARK: - Actions
extension MessageViewController: MessageDidArrived {
    func messageFetched() {
        tableView.reloadData()
    }
    
    func scrollToLastMessage(toRow: Int) {
        tableView.scrollToRow(at: IndexPath(row: 0, section: toRow), at: .bottom, animated: true)
    }
    
    @objc private func sendPressed() {
        messaegeViewModel.sendMessage(message: messageTextfield.text!) { (_) in
            self.messageTextfield.text = ""
        }
    }
}
