//
//  SettingsViewModel.swift
//  Cargram
//
//  Created by Ferhan Akkan on 13.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import Firebase

struct SettingsViewModel {
    
    let firebase = FirebaseUserService()
    
    //MARK: - Set Gesture && Profile Image Actions
    
    internal func openAlert(owner: SettingViewController) {
        
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
        
        let device = UIDevice.current
        
        if device.userInterfaceIdiom == .phone {
            UIApplication.getPresentedViewController()!.present(alert, animated: true, completion: nil)
        }
        
    }
    
    private func openCamera(owner: SettingViewController) {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            owner.imagePicker!.sourceType = UIImagePickerController.SourceType.camera
            owner.imagePicker!.allowsEditing = false
            UIApplication.getPresentedViewController()!.present(owner.imagePicker!, animated: true, completion: nil)
        }
        else {
            let alert  = UIAlertController(title: "OOPS", message: "Unknow Error", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            UIApplication.getPresentedViewController()!.present(alert, animated: true, completion: nil)
        }
    }
    
    private func openGallery(owner: SettingViewController) {
        owner.imagePicker!.sourceType = UIImagePickerController.SourceType.photoLibrary
        owner.imagePicker!.allowsEditing = true
        UIApplication.getPresentedViewController()!.present(owner.imagePicker!, animated: true, completion: nil)
    }
    
    private func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    internal func sendSelectedImage(image: UIImage) {
        let storage = Storage.storage().reference(withPath: "profileImage")
        if let name = Auth.auth().currentUser?.displayName {
            
            let store = storage.child("\(name).jpg")
            
            store.putData((image.jpegData(compressionQuality: 0.1))!, metadata: nil) { (metadata, error) in
                store.downloadURL { (url, error) in
                    guard let downloadURL = url else {return}
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.photoURL = downloadURL
                    changeRequest?.commitChanges { (_) in
                    }
                }
            }
        }
        
    }
    
    //MARK: - TableView
    
    internal func setTableViewRows(indexpath: Int) -> UITableViewCell{
        let cell = UITableViewCell()
        switch indexpath {
        case 0:
            cell.textLabel?.text = "Change password"
            cell.accessoryType = .detailButton
        case 1:
            cell.textLabel?.text = "Delete User"
            cell.accessoryType = .detailButton
        default:
            break
        }
        return cell
    }
    
    internal func didSelectTableViewRow(indexpath: Int) {
        switch indexpath {
        case 0:
            let alert = UIAlertController(title: "Do you want to Change Password?", message: "If yes we will send you a mail to change your password.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                if let email = Auth.auth().currentUser?.email {
                    Auth.auth().sendPasswordReset(withEmail: email) { error in
                        AppManager.shared.messagePresent(title: "Success", message: "We send you a mail chech you mail box", type: .success, isInternet: .nonInternetAlert)
                        self.firebase.signOut()
                    }
                }
            }))
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
            }))
            UIApplication.getPresentedViewController()!.present(alert, animated: true)
        case 1:
            let alert = UIAlertController(title: "Do you want to Delete your account?", message: "if you delete your account you can register with same mail again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                let user = Auth.auth().currentUser
                user?.delete { error in
                    if let error = error {
                        AppManager.shared.messagePresent(title: "Error", message: error.localizedDescription, type: .error, isInternet: .nonInternetAlert)
                    } else {
                        AppManager.shared.messagePresent(title: "Success", message: "Your account has been deleted", type: .success, isInternet: .nonInternetAlert)
                        self.firebase.signOut()
                    }
                }
            }))
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
            }))
            UIApplication.getPresentedViewController()!.present(alert, animated: true)
        default:
            break
        }
    }
}
