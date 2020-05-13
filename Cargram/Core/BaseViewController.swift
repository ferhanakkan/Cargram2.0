//
//  BaseViewController.swift
//  Cargram
//
//  Created by Ferhan Akkan on 11.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher
import StoreKit

class BaseViewController: UIViewController  {
    
    var sidebarView: SidebarView!
    var blackScreen: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.imageSetter()
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .gray
        navigationController?.navigationBar.barTintColor = .backgroundGreen
        imageSetter()
        sidebarView=SidebarView(frame: CGRect(x: 0, y: 0, width: 0, height: self.view.frame.height))
        sidebarView.delegate=self
        sidebarView.layer.zPosition=100
        self.view.isUserInteractionEnabled=true
        self.navigationController?.view.addSubview(sidebarView)
        
        blackScreen=UIView(frame: self.view.bounds)
        blackScreen.backgroundColor=UIColor(white: 0, alpha: 0.5)
        blackScreen.isHidden=true
        self.navigationController?.view.addSubview(blackScreen)
        blackScreen.layer.zPosition=99
        let tapGestRecognizer = UITapGestureRecognizer(target: self, action: #selector(blackScreenTapAction(sender:)))
        blackScreen.addGestureRecognizer(tapGestRecognizer)
    }
    
    @objc func btnMenuAction() {
        tabBarController?.tabBar.isHidden = true
        sidebarView.myTableView.reloadData()
        blackScreen.isHidden=false
        UIView.animate(withDuration: 0.3, animations: {
            self.sidebarView.frame=CGRect(x: 0, y: 0, width: 250, height: self.sidebarView.frame.height)
        }) { (complete) in
            self.blackScreen.frame=CGRect(x: self.sidebarView.frame.width, y: 0, width: self.view.frame.width-self.sidebarView.frame.width, height: self.view.bounds.height+100)
        }
    }
    
    @objc func blackScreenTapAction(sender: UITapGestureRecognizer) {
        tabBarController?.tabBar.isHidden = false
        blackScreen.isHidden=true
        blackScreen.frame=self.view.bounds
        UIView.animate(withDuration: 0.3) {
            self.sidebarView.frame=CGRect(x: 0, y: 0, width: 0, height: self.sidebarView.frame.height)
        }
    }
    
    private func imageSetter() {
        let navigationBarRightButton = UIBarButtonItem()
        let button = UIButton()
        
        DispatchQueue.main.async {
            if let data = UserDefaults.standard.value(forKey: "profileImage") as? Data{
                button.setImage(UIImage(data: data), for: .normal)
            }
            else {
                button.setImage(UIImage(named: "avatar"), for: .normal)
            }
        }
        button.cornerRadius = 15
        button.layer.borderWidth = 2
        button.layer.masksToBounds = false
        button.layer.borderColor = UIColor.gray.cgColor
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.addTarget(self, action: #selector(btnMenuAction), for: .touchUpInside)
        navigationBarRightButton.customView = button
        button.imageView?.contentMode = .scaleToFill
        self.navigationItem.leftBarButtonItem = navigationBarRightButton
    }

}

extension BaseViewController: SidebarViewDelegate {
    func sidebarDidSelectRow(row: Row) {
        tabBarController?.tabBar.isHidden = false
        blackScreen.isHidden=true
        blackScreen.frame=self.view.bounds
        UIView.animate(withDuration: 0.3) {
            self.sidebarView.frame=CGRect(x: 0, y: 0, width: 0, height: self.sidebarView.frame.height)
        }
        switch row {
            
        case .editProfile, .settings:
            //            if Auth.auth().currentUser != nil {
                            let vc = SettingViewController()
                            vc.hidesBottomBarWhenPushed = true
                            navigationController?.show(vc, sender: nil)
            //            } else {
            //                let vc = SplashViewController()
            //                vc.hidesBottomBarWhenPushed = true
            //                navigationController?.show(vc, sender: nil)
            //            }
            print("duzelt")
        case .rate:
            SKStoreReviewController.requestReview()
        case .vin:
            print("Vin is coming")
        case .carDetail:
            print("car detail")
        case .donate:
            let vc = DonateViewController()
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true, completion: nil)
        case .signOut:
            //            firebaseUser.signOut()
            print("signout")
        case .none:
            break
            //        default:  //Default will never be executed
        }
    }
}
