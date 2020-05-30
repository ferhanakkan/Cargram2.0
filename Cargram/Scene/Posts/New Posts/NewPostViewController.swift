//
//  NewPostViewController.swift
//  Cargram
//
//  Created by Ferhan Akkan on 20.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit

final class NewPostViewController: UIViewController {
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "avatar")
        return image
    }()
    
    let commitTextField: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.placeholder = "Enter Your Commit"
        return textfield
    }()
    
    let sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Upload", for: .normal)
        button.setMyButton(title: "Upload", color: .black, background: .darkGray, borderColor: .black)
        return button
    }()
    
    let newPostViewModel = NewPostViewModel()
    let imagePicker: UIImagePickerController? = UIImagePickerController()
    weak var delegate: NewPost?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
}

//MARK: - Setup UI

extension NewPostViewController {
    
    private func setUI() {
        view.backgroundColor = .white
        setImageView()
        setCommitTextfield()
        setUploadButton()
    }
    
    private func setImageView() {
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(view.frame.width*0.7*9/16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalToSuperview()
        }
        let gesture = UITapGestureRecognizer(target: self, action: #selector(imagePressed))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(gesture)
    }
    
    private func setCommitTextfield() {
        view.addSubview(commitTextField)
        commitTextField.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.height.equalTo(50)
        }
    }
    
    private func setUploadButton() {
        view.addSubview(sendButton)
        sendButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
            make.height.equalTo(50)
        }
        sendButton.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
    }
}

//MARK: - Actions

extension NewPostViewController {
    
    @objc private func sendButtonPressed() {
        if let imageData = imageView.image?.jpegData(compressionQuality: 0.5) {
            newPostViewModel.postData(commit: commitTextField.text!, imageData: imageData) {
                self.delegate?.newPostAdded()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc private func imagePressed() {
        newPostViewModel.openAlert(owner: self)
    }
}


//MARK: - Image Picker
extension NewPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        let data = image!.jpegData(compressionQuality: 0.3)
        imageView.image = UIImage(data: data!)
        newPostViewModel.imageSelected = true
    }
}

protocol NewPost: AnyObject {
    func newPostAdded()
}
