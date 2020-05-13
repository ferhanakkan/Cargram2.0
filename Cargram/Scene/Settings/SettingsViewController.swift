//
//  SettingsViewController.swift
//  Cargram
//
//  Created by Ferhan Akkan on 13.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit

final class SettingViewController: UIViewController {
 
    private let settingsViewModel = SettingsViewModel()
    
    lazy var tableView = UITableView()
    lazy var imageView = UIImageView ()
    lazy var imagePicker: UIImagePickerController? = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
        imageView.isUserInteractionEnabled = true
    }
    
}

//MARK: - SetupUI

extension SettingViewController {
    
    private func setUI() {
        view.backgroundColor = .white
        setImageView()
        setTableView()
    }
    
    private func setImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 2
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.clipsToBounds = true
        
        DispatchQueue.main.async {
            if let data = UserDefaults.standard.value(forKey: "profileImage") as? Data{
                self.imageView.image = UIImage(data: data)
            } else {
                self.imageView.image = UIImage(named: "avatar")
            }
        }
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
        }
    }
    
    private func setTableView() {
        view.addSubview(tableView)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        
        tableView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    
}

//MARK: - TableView Delegate & DataSource
extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return settingsViewModel.setTableViewRows(indexpath: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        settingsViewModel.didSelectTableViewRow(indexpath: indexPath.row)
    }
}

//MARK: - Image Picker

extension SettingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func imageTapped() {
        settingsViewModel.openAlert(owner: self)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        if let data:Data = image?.pngData() {
            UserDefaults.standard.setValue(data, forKey: "profileImage")
        }
        imageView.image = image
        settingsViewModel.sendSelectedImage(image: image!)
    }
}

