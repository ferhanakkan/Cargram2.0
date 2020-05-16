//
//  ToDoCreateViewModel.swift
//  Cargram
//
//  Created by Ferhan Akkan on 15.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import RealmSwift

protocol ToDoCreated {
    func todoCreated()
}

final class ToDoCreateViewModel {
    
    var dataArray: [Data] = []
    var delegate: ToDoCreated?
    
    func deleteImage(index: Int) {
        dataArray.remove(at: index)
    }
    
    func createTopic(title: String, subTitle: String, selectedDate: String? = nil, completion: @escaping(Bool) -> Void) {
        if title != "" && subTitle != "" {
            let object = ToDoRealmModel()
            object.toDoTitle = title
            object.toDoDescription = subTitle
            if dataArray.isEmpty {
                object.picArray.append((UIImage(named: "gray")?.jpegData(compressionQuality: 0.5))!)
            } else {
                for data in dataArray {
                    object.picArray.append(data)
                }
            }
            object.deathline = selectedDate
            
            let realm = try! Realm()
            do {
                try realm.write {
                    realm.add(object)
                }
            } catch {
                AppManager.shared.messagePresent(title: "OPPS", message: "Plan didn't saved", type: .error, isInternet: .nonInternetAlert)
            }
            
            delegate?.todoCreated()
            completion(true)
        } else {
            errorAlert()
        }
    }
    
    func errorAlert() {
        AppManager.shared.messagePresent(title: "OOPS", message: "Please chech title and subtitle can't be empty", type: .error, isInternet: .nonInternetAlert)
    }
    
    func setCollectionViewRow() -> Int {
        if dataArray.count == 0 {
            return 1
        } else {
            return dataArray.count+1
        }
    }
    
    func setCollectionViewCell(owner: ToDoCreateViewController, indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row != dataArray.count {
            switch dataArray.count {
            case 0:
                let cell = owner.collectionView.dequeueReusableCell(withReuseIdentifier: "ToDoAddCollectionViewCell", for: indexPath) as! ToDoAddCollectionViewCell
                cell.delegate = owner
                return cell
            default:
                let cell = owner.collectionView.dequeueReusableCell(withReuseIdentifier: "ToDoRemoveCollectionViewCell", for: indexPath) as! ToDoRemoveCollectionViewCell
                cell.button.backgroundColor = .clear
                cell.button.setImage(UIImage(data:  dataArray[indexPath.row]), for: .normal)
                cell.delegate = owner
                cell.detailDelegate = owner
                cell.selectedIndex = indexPath.row
                return cell
            }
        } else {
            let cell = owner.collectionView.dequeueReusableCell(withReuseIdentifier: "ToDoAddCollectionViewCell", for: indexPath) as! ToDoAddCollectionViewCell
            cell.delegate = owner
            return cell

        }
    }
}

//MARK: - Set Gesture && Profile Image Actions

extension ToDoCreateViewModel {
    internal func openAlert(owner: ToDoCreateViewController) {
        
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
            
            owner.present(alert, animated: true, completion: nil)
        }
        
    }
    
    private func openCamera(owner: ToDoCreateViewController) {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            owner.imagePicker!.sourceType = UIImagePickerController.SourceType.camera
            owner.imagePicker!.allowsEditing = false
            owner.present(owner.imagePicker!, animated: true, completion: nil)
        }
        else {
            let alert  = UIAlertController(title: "OOPS", message: "Unknow Error", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            owner.present(alert, animated: true, completion: nil)
        }
    }
    
    private func openGallery(owner: ToDoCreateViewController) {
        owner.imagePicker!.sourceType = UIImagePickerController.SourceType.photoLibrary
        owner.imagePicker!.allowsEditing = true
        owner.present(owner.imagePicker!, animated: true, completion: nil)
    }
    
    private func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
        
}



