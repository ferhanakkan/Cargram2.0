//
//  ToDoCreateViewController.swift
//  Cargram
//
//  Created by Ferhan Akkan on 15.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit
import BEMCheckBox

final class ToDoCreateViewController: UIViewController {
    
    let mainSubview = UIView()
    let titleTextfield = UITextField()
    let subTitleTextfield = UITextField()
    let deathlineLabel = UILabel()
    let pickerToolbar = UIToolbar()
    let datePicker = UIDatePicker()
    let dateTextfield = UITextField()
    let createButton = UIButton()
    let cancelButton = UIButton()
    let imagePicker: UIImagePickerController? = UIImagePickerController()

    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.minimumLineSpacing = 5
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 200)
        let collectionview = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0 ), collectionViewLayout: layout)
        collectionview.backgroundColor = .clear
        collectionview.register(ToDoRemoveCollectionViewCell.self, forCellWithReuseIdentifier: "ToDoRemoveCollectionViewCell")
        collectionview.register(ToDoAddCollectionViewCell.self, forCellWithReuseIdentifier: "ToDoAddCollectionViewCell")
        return collectionview
    }()
    
    let toDoCreateViewModel = ToDoCreateViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}

//MARK: - Setup UI

extension ToDoCreateViewController {
    
    private func setUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        setMainView()
        setTitle()
        setSubtitle()
        setCollectionView()
        setDeathLine()
        setDateTextfield()
        setPickerToolbar()
        setDatePicker()
        setCancelButton()
        setCreateButton()
    }
    
    private func setMainView() {
        view.addSubview(mainSubview)
        mainSubview.snp.makeConstraints { (make) in
            make.height.equalTo(view.frame.height*0.8)
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
        titleTextfield.placeholder = "To Do Title"
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
        subTitleTextfield.placeholder = "To Do Description"
    }
    
    private func setCollectionView() {
        mainSubview.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalToSuperview().offset(20)
            make.height.lessThanOrEqualTo(80)
            make.top.equalTo(subTitleTextfield.snp.bottom).offset(20)
        }
    }

    private func setDeathLine() {
        mainSubview.addSubview(deathlineLabel)
        deathlineLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(collectionView.snp.bottom).offset(20)
            make.height.equalTo(40)
        }
        deathlineLabel.text = "Death Line"
        deathlineLabel.font = .systemFont(ofSize: 15)
        deathlineLabel.textColor = .black
    }
    
    private func setDateTextfield() {
        mainSubview.addSubview(dateTextfield)
        dateTextfield.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom).offset(20)
            make.leading.equalTo(deathlineLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        dateTextfield.borderStyle = .roundedRect
        dateTextfield.placeholder = "Select Time"
        dateTextfield.inputAccessoryView = pickerToolbar
        dateTextfield.inputView = datePicker
        
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
        datePicker.timeZone = NSTimeZone.local
        datePicker.backgroundColor = .white
        let calendar = Calendar(identifier: .gregorian)
        var comps = DateComponents()
        comps.month = 12
        let maxDate = calendar.date(byAdding: comps, to: Date())
        comps.month = 0
        comps.day = -1
        let minDate = calendar.date(byAdding: comps, to: Date())
        datePicker.maximumDate = maxDate
        datePicker.minimumDate = minDate

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
            make.top.greaterThanOrEqualTo(collectionView.snp.bottom).offset(20)
        }
        createButton.backgroundColor = .gray
        createButton.setTitle("Create", for: .normal)
        createButton.layer.cornerRadius = 15
        createButton.setTitleColor(.white, for: .normal)
        createButton.titleLabel!.font = .boldSystemFont(ofSize: 15)
        createButton.addTarget(self, action: #selector(createPressed), for: .touchUpInside)
    }
}

//MARK: - Actions

extension ToDoCreateViewController {
    
    @objc private func createPressed() {
        toDoCreateViewModel.createTopic(title: titleTextfield.text!, subTitle: subTitleTextfield.text!, selectedDate: dateTextfield.text!) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func cancelPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func pickerCancelButton(_ button: UIBarButtonItem?) {
        dateTextfield.resignFirstResponder()
    }
    
    @objc func pickerDoneButton(_ button: UIBarButtonItem?) {
        dateTextfield.resignFirstResponder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.timeZone = .autoupdatingCurrent
        dateTextfield.text = dateFormatter.string(from: datePicker.date)
    }

}

//MARK: - CollectionView Delegate & DataSource

extension ToDoCreateViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return toDoCreateViewModel.setCollectionViewRow()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return toDoCreateViewModel.setCollectionViewCell(owner: self, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height-10, height: collectionView.frame.height-10)
    }
}

//MARK: - Image Add Remove Protocol

extension ToDoCreateViewController: ImageAddProtocol, ImageRemoveProtocol, ImageDetailShow {
    func imageProtocolShow(selectedCell: Int) {
        let vc = ToDoDetailImageShowViewController()
        vc.imageView.image = UIImage(data: toDoCreateViewModel.dataArray[selectedCell])
        present(vc, animated: true)
    }
    
    func imageProtocolAdd() {
        toDoCreateViewModel.openAlert(owner: self)
    }
    
    func imageProtocolRemove(selectedCell: Int) {
        toDoCreateViewModel.deleteImage(index: selectedCell)
        collectionView.reloadData()
    }
}

//MARK: - Image Picker
extension ToDoCreateViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        let data = image!.jpegData(compressionQuality: 0.3)
        toDoCreateViewModel.dataArray.append(data!)
        collectionView.reloadData()
    }
}
