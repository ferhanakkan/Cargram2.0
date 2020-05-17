//
//  ToDoCollectionViewCell.swift
//  Cargram
//
//  Created by Ferhan Akkan on 15.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit

final class ToDoCollectionViewCell: UICollectionViewCell {
    
    let image: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 15
        return view
    }()
    
    let isCompletedImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 15
        view.image = UIImage(named: "successful")
        return view
    }()
    
    let subView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 15
        return view
    }()
    
    let timeSubView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 15
        return view
    }()
    
    let timeLabel: UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        title.textAlignment = .left
        title.font = UIFont.boldSystemFont(ofSize: 20)
        title.textColor = .white
        return title
    }()
    
    let title: UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        title.textAlignment = .left
        title.font = UIFont.boldSystemFont(ofSize: 20)
        title.textColor = .white
        return title
    }()
    
    let subTitle: UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 15)
        title.textColor = .white
        return title
    }()
    
    var endTime: Double? = nil {
        didSet {
            timeLabel.text = timeToDeathLine()
        }
    }
    
    var timer:Timer?

    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.cornerRadius = 15
        contentView.addSubview(image)
        contentView.addSubview(subView)
        contentView.addSubview(timeSubView)
        subView.addSubview(title)
        subView.addSubview(subTitle)
        image.addSubview(isCompletedImage)
        timeSubView.addSubview(timeLabel)
        
        image.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        isCompletedImage.snp.makeConstraints { (make) in
            make.height.width.equalTo(60)
            make.top.leading.equalToSuperview().offset(10)
        }
        
        timeSubView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(5)
            make.trailing.bottom.equalToSuperview().inset(5)
        }
        
        
        subView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }

        title.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(15)
            make.leading.equalToSuperview().offset(15)
        }

        subTitle.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().inset(20)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ToDoCollectionViewCell {

    @objc func timeCounter()
    {
        let currentTime = Double(Date().timeIntervalSince1970)
        let calculatedTime = Int(endTime! - currentTime)
        let minute = 60
        let sec = calculatedTime % minute
        let min = calculatedTime / minute
        timeLabel.text = "\(min) min \(sec) sec left"
        
        if calculatedTime <= 1 {
            timer?.invalidate()
            timeLabel.text = "End Time Ended"
        }
    }

    
    func timeToDeathLine() -> String{
        let currentTime = Double(Date().timeIntervalSince1970)
        let calculatedTime = Int(endTime! - currentTime)
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = 30 * day
        
        if calculatedTime <= 0{
            return "End Time Ended"
        } else if calculatedTime < minute {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timeCounter), userInfo: nil, repeats: true)
            return "\(Int(calculatedTime)) second left"
        } else if calculatedTime < hour {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timeCounter), userInfo: nil, repeats: true)
            return "\(calculatedTime/minute) minute left"
        } else if calculatedTime < day {
            return "\(calculatedTime/hour) hour left"
        } else if calculatedTime < week {
            return "\(calculatedTime/day) day left"
        } else if calculatedTime < month {
            return "\(calculatedTime/week) week left"
        } else {
            return "\(calculatedTime/month) month left"
        }
    }

}
