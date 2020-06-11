//
//  Donate.swift
//  Cargram
//
//  Created by Ferhan Akkan on 11.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import StoreKit
import SnapKit

class DonateViewController: UIViewController, SKPaymentTransactionObserver {
    
    let mainView = UIView()
    let thankImage = UIImageView()
    let label = UILabel()
    let oneDolarView = UIView()
    let fiveDolarView = UIView()
    let tenDolarView = UIView()
    let stackView = UIStackView()
    let closeView = UIView()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(displayP3Red: 9/255, green: 18/255, blue: 17/255, alpha: 0.6)
        setMainView()
        setImageView()
        setLabel()
        setOneDolar()
        setFiveDolar()
        setTenDolar()
        setStackView()
        setCloseView()
        setGesture()
        SKPaymentQueue.default().add(self)
    }
    
    private func setMainView(){
        view.addSubview(mainView)
        mainView.backgroundColor = .white
        mainView.cornerRadius = 20
        
        mainView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalTo(550)
            make.width.equalTo(325)
        }
    }
    
    private func setImageView() {
        mainView.addSubview(thankImage)
        thankImage.image = UIImage(named: "thankYou")
        thankImage.contentMode = .scaleAspectFit
        
        thankImage.snp.makeConstraints { (make) in
            make.height.equalTo(80)
            make.width.equalTo(280)
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setLabel() {
        mainView.addSubview(label)
        label.text = "Do you wanna order something to me?"
        label.textColor = .darkText
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 25.0)
        label.textAlignment = .center
        
        label.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(80)
            make.top.equalTo(thankImage.snp.bottom).offset(20)
        }
    }
    
    private func setStackView() {
        mainView.addSubview(stackView)
        stackView.addArrangedSubview(oneDolarView)
        stackView.addArrangedSubview(fiveDolarView)
        stackView.addArrangedSubview(tenDolarView)
        
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        stackView.snp.makeConstraints { (make) in
            make.bottom.trailing.equalToSuperview().inset(20)
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(label.snp.bottom).offset(20)
        }
    }
    
    private func setOneDolar() {
        oneDolarView.cornerRadius = 20
        oneDolarView.layer.borderColor = UIColor.rouge.cgColor
        oneDolarView.layer.borderWidth = 3.0
        
        let localLabel = UILabel()
        localLabel.textColor = .darkText
        localLabel.numberOfLines = 0
        localLabel.font = UIFont.systemFont(ofSize: 15)
        localLabel.textAlignment = .center
        localLabel.text = "A coffee just for 1$"
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "coffee")
        imageView.contentMode = .scaleAspectFit
        
        oneDolarView.addSubview(imageView)
        oneDolarView.addSubview(localLabel)
        
        imageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(60)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        localLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(imageView.snp.trailing).offset(20)
            make.top.equalToSuperview().offset(20)
            make.bottom.trailing.equalToSuperview().inset(20)
        }
        
    }
    
    private func setFiveDolar() {
        fiveDolarView.cornerRadius = 20
        fiveDolarView.layer.borderColor = UIColor.rouge.cgColor
        fiveDolarView.layer.borderWidth = 3.0
        
        let localLabel = UILabel()
        localLabel.textColor = .darkText
        localLabel.numberOfLines = 0
        localLabel.font = UIFont.systemFont(ofSize: 15)
        localLabel.textAlignment = .center
        localLabel.text = "A burger just for 5$"
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "burger")
        imageView.contentMode = .scaleAspectFit
        
        fiveDolarView.addSubview(imageView)
        fiveDolarView.addSubview(localLabel)
        
        imageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(60)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        localLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(imageView.snp.trailing).offset(20)
            make.top.equalToSuperview().offset(20)
            make.bottom.trailing.equalToSuperview().inset(20)
        }
        
    }
    
    private func setTenDolar() {
        tenDolarView.cornerRadius = 20
        tenDolarView.layer.borderColor = UIColor.rouge.cgColor
        tenDolarView.layer.borderWidth = 3.0
        
        let localLabel = UILabel()
        localLabel.textColor = .darkText
        localLabel.numberOfLines = 0
        localLabel.font = UIFont.systemFont(ofSize: 15)
        localLabel.textAlignment = .center
        localLabel.text = "A burger menu just for 10$"
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "burgerMenu")
        imageView.contentMode = .scaleAspectFit
        
        tenDolarView.addSubview(imageView)
        tenDolarView.addSubview(localLabel)
        
        imageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(60)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        localLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(imageView.snp.trailing).offset(20)
            make.top.equalToSuperview().offset(20)
            make.bottom.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setCloseView() {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "xmark")
        closeView.addSubview(imageView)
        closeView.backgroundColor = .white
        closeView.cornerRadius = 12.5
        view.addSubview(closeView)
        
        closeView.snp.makeConstraints { (make) in
            make.height.width.equalTo(25)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(5)
            make.trailing.equalToSuperview().inset(10)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.width.equalTo(15)
        }
    }
    
    
    private func setGesture() {
        oneDolarView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(donateOneSelection)))
        fiveDolarView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(donateFiveselection)))
        tenDolarView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(donateTenSelection)))
        closeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissSelection)))
    }
    
    @objc func donateOneSelection() {
        setDonationInteraction()
        buyPremiumQuotes(productID: "com.ferhanakkan.Cargram.Coffee2")
    }
    
    @objc func donateFiveselection() {
        setDonationInteraction()
        buyPremiumQuotes(productID: "com.ferhanakkan.Cargram.Burger2")
    }
    
    @objc func donateTenSelection() {
        setDonationInteraction()
        buyPremiumQuotes(productID: "com.ferhanakkan.Cargram.BurgerMenu2")
    }
    
    @objc func dismissSelection() {
       dismiss(animated: true, completion: nil)
    }
    
    
}

extension DonateViewController {
    func buyPremiumQuotes(productID: String) {
        
         if SKPaymentQueue.canMakePayments() {
             //Can make payments
            let paymentRequest = SKMutablePayment()
             paymentRequest.productIdentifier = productID
             SKPaymentQueue.default().add(paymentRequest)
 
         } else {
             //Can't make payments
             print("User can't make payments")
         }
     }
     
     func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
         for transaction in transactions {
            switch  transaction.transactionState {
            case .purchased:
                //User payment successful
                print("Transaction successful!")
                SKPaymentQueue.default().finishTransaction(transaction)
                setDonationInteraction()
            case .failed:
                //Payment failed
                if let error = transaction.error {
                    let errorDescription = error.localizedDescription
                    print("Transaction failed due to error: \(errorDescription)")
                    setDonationInteraction()
                }
                SKPaymentQueue.default().finishTransaction(transaction)
            case .restored:
                print("Transaction restored")
                SKPaymentQueue.default().finishTransaction(transaction)
                setDonationInteraction()
            default:
                break
            }
         }
         
     }
     
     @IBAction func restorePressed(_ sender: UIBarButtonItem) {  /////DİD BUY BEFORE CHECK
         SKPaymentQueue.default().restoreCompletedTransactions()
     }
    
    private func setDonationInteraction() {
        oneDolarView.isUserInteractionEnabled = !oneDolarView.isUserInteractionEnabled
        fiveDolarView.isUserInteractionEnabled = !fiveDolarView.isUserInteractionEnabled
        tenDolarView.isUserInteractionEnabled = !tenDolarView.isUserInteractionEnabled
    }
}

