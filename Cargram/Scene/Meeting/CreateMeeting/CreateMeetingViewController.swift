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
    let selectedLocationLabel = UILabel()
    let eventButton = UIButton()
    let pickerToolbar = UIToolbar()
    let datePicker = UIDatePicker()
    
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
        setDatePicker()
        setPickerToolbar()
        setStack()
        setLocationButton()
        setSelectedLocationLabel()
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
        timeTextField.inputAccessoryView = pickerToolbar
        timeTextField.inputView = datePicker
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
        locationButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        locationButton.backgroundColor = .gray
        locationButton.cornerRadius = 15
        view.addSubview(locationButton)
        locationButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalTo(stack.snp.bottom).offset(10)
            make.height.equalTo(50)
        }
        locationButton.addTarget(self, action: #selector(locationButtonPressed), for: .touchUpInside)
    }
    
    private func setSelectedLocationLabel() {
        selectedLocationLabel.text = "Selected location : Not Selected"
        selectedLocationLabel.font = UIFont.boldSystemFont(ofSize: 30)
        selectedLocationLabel.minimumScaleFactor = 0.3
        selectedLocationLabel.adjustsFontSizeToFitWidth = true
        selectedLocationLabel.numberOfLines = 0
        
        view.addSubview(selectedLocationLabel)
        selectedLocationLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalTo(locationButton.snp.bottom).offset(10)
        }
    }
    
    private func setCreateButton() {
        eventButton.setTitle("Create Event", for: .normal)
        eventButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        eventButton.backgroundColor = .gray
        eventButton.cornerRadius = 15
        view.addSubview(eventButton)
        eventButton.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(50)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
        }
        eventButton.addTarget(self, action: #selector(createButtonPressed), for: .touchUpInside)
    }
    
    
    private func setPickerToolbar() {
        pickerToolbar.autoresizingMask = .flexibleHeight
        pickerToolbar.barStyle = .default
        pickerToolbar.barTintColor = .white
        pickerToolbar.backgroundColor = .white
        pickerToolbar.isTranslucent = false
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action:
            #selector(pickerCancelButton(_:)))
        cancelButton.tintColor = UIColor.black
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action:
            #selector(pickerDoneButton(_:)))
        doneButton.tintColor = UIColor.black
        pickerToolbar.items = [cancelButton, flexSpace, doneButton]
    }
    
    private func setDatePicker() {
        datePicker.datePickerMode = .dateAndTime
        datePicker.timeZone = .current
        datePicker.backgroundColor = .white
        datePicker.locale = .current
        let calendar = Calendar(identifier: .gregorian)
        var comps = DateComponents()
        comps.month = 12
        let maxDate = calendar.date(byAdding: comps, to: Date())
        comps.month = 0
        comps.day = 0
        let minDate = calendar.date(byAdding: comps, to: Date())
        datePicker.maximumDate = maxDate
        datePicker.minimumDate = minDate
    }
    
}

//MARK: - Actions

extension CreateMeetingViewController {
    
    @objc func pickerDoneButton(_ button: UIBarButtonItem?) {
        timeTextField.resignFirstResponder()
        createMettingViewModel.didDateSetted = true
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.timeZone = .autoupdatingCurrent
        timeTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc func pickerCancelButton(_ button: UIBarButtonItem?) {
        timeTextField.resignFirstResponder()
    }
    
    @objc private func locationButtonPressed () {
        let vc = MapViewController()
        vc.delegate = self
        vc.type = .selectArea
        navigationController?.show(vc, sender: nil)
    }
    
    @objc private func createButtonPressed () {
        createMettingViewModel.createMeeting(title: titleTextfield.text!, description: descriptionTextField.text!, selectedDate: datePicker.date) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}

//MARK: - Select Area Protocol

extension CreateMeetingViewController: SelectedArea {
    func selectedArea(latitude: Double, longitude: Double, address: String) {
        selectedLocationLabel.text = "Selected location : \(address)"
        createMettingViewModel.selectedAreaAddress = address
        createMettingViewModel.selectedAreaLatitude = latitude
        createMettingViewModel.selectedAreaLongitude = longitude
    }
}
