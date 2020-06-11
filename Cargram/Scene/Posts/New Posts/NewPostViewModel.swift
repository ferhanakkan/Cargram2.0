//
//  NewPostViewModel.swift
//  Cargram
//
//  Created by Ferhan Akkan on 20.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import PromiseKit

class NewPostViewModel {
    
    let firebase = FirebasePostService()
    var imageSelected = false
    
    func postData(commit: String, imageData: Data, completion: @escaping() -> Void) {

        if commit != "" && imageSelected {
            LoadingView.show()
            
            firstly {
                firebase.postImage(data: imageData)
            }.then { url in
                self.firebase.getUserImageUrl(imageUrl: url)
            }.then { urlArray in
                self.firebase.postDatas(commit: commit, postUrl: urlArray[0], profileImageUrl: urlArray[1])
            }.done {
                completion()
            }.ensure {
                LoadingView.hide()
            }.catch { (err) in
                AppManager.shared.messagePresent(title: "OOPS", message: err.localizedDescription, type: .error, isInternet: .nonInternetAlert)
            }
        } else {
            AppManager.shared.messagePresent(title: "OOPS", message: "Please enter a commit or select a image", type: .error, isInternet: .nonInternetAlert)
        }
        
    }
    
}

//MARK: - Set Gesture && Profile Image Actions

extension NewPostViewModel {
    internal func openAlert(owner: NewPostViewController) {
        
        let alert: UIAlertController = UIAlertController(title: "Chose which way do you prefer", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.openCamera(owner: owner)
        }
        
        let galleryAction = UIAlertAction(title: "Galery", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.openGallery(owner: owner)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) {
            UIAlertAction in
        }
        
        owner.imagePicker?.delegate = owner
        
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)

        
        let groundView = UIApplication.getPresentedViewController()!.view
        
        alert.popoverPresentationController?.sourceView = groundView!
        alert.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
        alert.popoverPresentationController?.sourceRect = CGRect(x: groundView!.bounds.midX, y: groundView!.bounds.midY, width: 0, height: 0)
        UIApplication.getPresentedViewController()!.present(alert, animated: true)

    }
    
    private func openCamera(owner: NewPostViewController) {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            owner.imagePicker!.sourceType = UIImagePickerController.SourceType.camera
            owner.imagePicker!.allowsEditing = true
            owner.present(owner.imagePicker!, animated: true, completion: nil)
        }
        else {
            let alert  = UIAlertController(title: "OOPS", message: "Unknow Error", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            owner.present(alert, animated: true, completion: nil)
        }
    }
    
    private func openGallery(owner: NewPostViewController) {
        owner.imagePicker!.sourceType = UIImagePickerController.SourceType.photoLibrary
        owner.imagePicker!.allowsEditing = true
        owner.present(owner.imagePicker!, animated: true, completion: nil)
    }
    
    private func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

