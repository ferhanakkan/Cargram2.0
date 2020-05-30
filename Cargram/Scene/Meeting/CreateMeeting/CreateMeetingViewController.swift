//
//  CreateMeetingViewController.swift
//  Cargram
//
//  Created by Ferhan Akkan on 29.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit

class CreateMeetingViewController: UIViewController {
    
    let titleTextfield = UITextField()
    let descriptionTextField = UITextField()
    let timeTextField = UITextField()
    let stack = UIStackView()
    let locationButton = UIButton()
    let eventButton = UIButton()
    
    let createMettingViewModel = CreateMeetingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}

//MARK: - Set UI

extension CreateMeetingViewController {
    
    private func setUI() {
        view.backgroundColor = .white
        setTitleTextfield()
        setDescriptionTextfield()
        setTimeTextfield()
        setStack()
        setLocationButton()
        setCreateButton()
    }
    
    private func setTitleTextfield() {
        titleTextfield.placeholder = "Enter Title"
        titleTextfield.borderStyle = .roundedRect
        titleTextfield.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
    }
    
    private func setDescriptionTextfield() {
        descriptionTextField.placeholder = "Enter Descrpition"
        descriptionTextField.borderStyle = .roundedRect
        descriptionTextField.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
    }
    
    private func setTimeTextfield() {
        timeTextField.placeholder = "Select Date"
        timeTextField.borderStyle = .roundedRect
        timeTextField.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
    }
    
    private func setStack() {
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.addArrangedSubview(titleTextfield)
        stack.addArrangedSubview(descriptionTextField)
        stack.addArrangedSubview(timeTextField)
        view.addSubview(stack)
        
        stack.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
        }
    }
    
    private func setLocationButton() {
        locationButton.setTitle("Set Event Location", for: .normal)
        locationButton.backgroundColor = .gray
        locationButton.cornerRadius = 15
        view.addSubview(locationButton)
        locationButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalTo(stack.snp.bottom).offset(10)
            make.height.equalTo(50)
        }
    }
    
    private func setCreateButton() {
        eventButton.setTitle("Create Event", for: .normal)
        eventButton.backgroundColor = .gray
        eventButton.cornerRadius = 15
        view.addSubview(eventButton)
        eventButton.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(50)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
        }
    }
    
}
