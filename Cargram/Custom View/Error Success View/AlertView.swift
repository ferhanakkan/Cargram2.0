//
//  AlertView.swift
//  Cargram
//
//  Created by Ferhan Akkan on 11.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit

final class AlertView: UIViewController {
    
    //MARK: - Properties
    var titleLabel: UILabel = UILabel()
    var messagelabel: UILabel = UILabel()
    var imageView: UIImageView = UIImageView()
    var mainView: UIView = UIView()
    
    var okButton = UIButton()
    var retryButton: UIButton? = nil
    
    lazy var imageTypeSelector: ImageType = .error
    lazy var internetConnectionButtonSelector: InternetAlert = .nonInternetAlert
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(displayP3Red: 9/255, green: 18/255, blue: 17/255, alpha: 0.6)
    }
    
    //MARK: - Setup UI
    
    private func setUI() {
        setMainView()
        setImageView()
        setTitle()
        setMessage()
        setOkButton()
        setRetryButton()
    }
    private func setMainView() {
        view.addSubview(mainView)
        
        mainView.snp.makeConstraints { (make) in
            make.height.equalTo(400)
            make.width.equalTo(300)
            make.center.equalToSuperview()
        }
        mainView.cornerRadius = 20
    }
    
    private func setImageView() {
        mainView.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(80)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        
        imageView.contentMode = .scaleToFill
        
        imageTypeSelector == .error ? (imageView.image = #imageLiteral(resourceName: "alert") ): (imageView.image = #imageLiteral(resourceName: "success"))
        
    }
    
    private func setTitle() {
        mainView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setMessage() {
        mainView.addSubview(messagelabel)
        
        messagelabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setOkButton() {
        mainView.addSubview(okButton)
        
        okButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(messagelabel.snp.bottom).offset(20)
            make.height.equalTo(50)
            
            okButton.titleLabel?.text = "OK"
            okButton.backgroundColor = .green
            
            if internetConnectionButtonSelector == .nonInternetAlert {
                make.bottom.equalToSuperview().inset(20)
                okButton.titleLabel?.text = "Quit"
            }
            okButton.addTarget(self, action: #selector(okButtonAction), for: .touchUpInside)
        }
    }
    
    private func setRetryButton() {
        if internetConnectionButtonSelector == .isInternetAlert {
            mainView.addSubview(retryButton!)
            
            retryButton!.snp.makeConstraints { (make) in
                make.leading.equalToSuperview().offset(20)
                make.trailing.equalToSuperview().inset(20)
                make.top.equalTo(okButton.snp.bottom).offset(20)
                make.bottom.equalToSuperview().inset(20)
                make.height.equalTo(50)
            }
            retryButton!.titleLabel?.text = "Retry"
            retryButton!.backgroundColor = .green
            retryButton!.addTarget(self, action: #selector(retryButtonAction), for: .touchUpInside)
        }
    }
    
    //MARK: - Actions
    
    @objc private func okButtonAction() {
        if internetConnectionButtonSelector == .nonInternetAlert {
            exit(0)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc  private func retryButtonAction() {
        //Try to figure it out with better solution
        
        dismiss(animated: true, completion: nil)
        if AppManager.shared.reachability.connection == .unavailable {
            let vc = AlertView()
            vc.modalPresentationStyle = .overFullScreen
            present(AlertView(), animated: true)
        }
    }
    
}

enum ImageType {
    case success
    case error
}

enum InternetAlert {
    case isInternetAlert
    case nonInternetAlert
}
