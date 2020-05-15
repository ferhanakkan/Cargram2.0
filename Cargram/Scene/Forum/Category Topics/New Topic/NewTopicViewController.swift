//
//  NewTopicViewController.swift
//  Cargram
//
//  Created by Ferhan Akkan on 15.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit
import BEMCheckBox

final class NewTopicViewController: UIViewController {
    
    let mainSubview = UIView()
    let titleTextfield = UITextField()
    let subTitleTextfield = UITextField()
    let createButton = UIButton()
    let cancelButton = UIButton()
    let chechBox = BEMCheckBox()
    
    private let newTopicViewModel = NewTopicViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
    }
}

//MARK: - Setup UI

extension NewTopicViewController {
    
    private func setUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        setMainView()
        setTitle()
        setSubtitle()
        setCancelButton()
        setCreateButton()
        setCheckBox()
    }
    
    private func setMainView() {
        view.addSubview(mainSubview)
        mainSubview.snp.makeConstraints { (make) in
            make.height.equalTo(view.frame.height*0.6)
            make.width.equalTo(view.frame.width*0.8)
            make.center.equalToSuperview()
        }
        mainSubview.cornerRadius = 15
        mainSubview.backgroundColor = .white
    }
    
    private func setTitle() {
        mainSubview.addSubview(titleTextfield)
        titleTextfield.snp.makeConstraints { (make) in
            make.leading.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        titleTextfield.borderStyle = .roundedRect
        titleTextfield.placeholder = "Topic Title"
    }

    private func setSubtitle() {
        mainSubview.addSubview(subTitleTextfield)
        subTitleTextfield.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.top.equalTo(titleTextfield.snp.bottom).offset(20)
        }
        subTitleTextfield.borderStyle = .roundedRect
        subTitleTextfield.placeholder = "Topic Description"
    }
    
    private func setCancelButton() {
        mainSubview.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { (make) in
            make.trailing.bottom.equalToSuperview().inset(20)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(40)
        }
        cancelButton.backgroundColor = .gray
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.layer.cornerRadius = 15
        cancelButton.titleLabel!.font = .boldSystemFont(ofSize: 15)
        cancelButton.addTarget(self, action: #selector(cancelPressed), for: .touchUpInside)
    }
    
    private func setCreateButton() {
        mainSubview.addSubview(createButton)
        createButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(80)
            make.height.equalTo(40)
        }
        createButton.backgroundColor = .gray
        createButton.setTitle("Create", for: .normal)
        createButton.layer.cornerRadius = 15
        createButton.setTitleColor(.white, for: .normal)
        createButton.titleLabel!.font = .boldSystemFont(ofSize: 15)
        createButton.addTarget(self, action: #selector(createPressed), for: .touchUpInside)
    }
    
    private func setCheckBox() {
        let title = UILabel()
        title.numberOfLines = 0
        title.text = "Show your name in Topic ?"
        mainSubview.addSubview(title)
        
        title.snp.makeConstraints { (make) in
            make.top.equalTo(subTitleTextfield.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        chechBox.onTintColor = .red
        chechBox.onCheckColor = .orange
        mainSubview.addSubview(chechBox)
        chechBox.snp.makeConstraints { (make) in
            make.height.width.equalTo(30)
            make.centerY.equalTo(title)
            make.leading.equalTo(title.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
}

//MARK: - Actions

extension NewTopicViewController {
    
    @objc private func createPressed() {
        newTopicViewModel.createTopic(title: titleTextfield.text!, subTitle: subTitleTextfield.text!, check: chechBox.on)
    }
    
    @objc private func cancelPressed() {
        dismiss(animated: true, completion: nil)
    }
}
