//
//  MeetingViewController.swift
//  Cargram
//
//  Created by Ferhan Akkan on 29.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit

class MeetingViewController: BaseViewController {
    
    let comingEventView = UIView()
    let didEndEvent = UIView()
    let createEvent = UIView()
    let upcomingLabel = UILabel()
    let didEndEventLabel = UILabel()
    
    let meetingViewModel = MeetingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
}

//MARK: - Set UI

extension MeetingViewController {
    private func setUI() {
        view.backgroundColor = .white
        setComingView()
        endEventView()
        createEventView()
        setEndedLabel()
        setUpcomingLabel()
        setStack()
    }
    
    
    private func setComingView() {
        comingEventView.backgroundColor = .gray
        comingEventView.layer.borderWidth = 3
        comingEventView.borderAndCorner(radius: 15, color: .black, width: 3)
        let image = UIImageView()
        image.image = UIImage(named: "upcomingCalendar")
        image.contentMode = .scaleAspectFit
        let title = UILabel()
        title.textAlignment = .center
        title.text = "Upcoming Events"
        title.font = UIFont.boldSystemFont(ofSize: 10)
        title.textColor = .white
        comingEventView.addSubview(image)
        image.snp.makeConstraints { (make) in
            make.height.width.equalTo(80)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
        comingEventView.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.top.equalTo(image.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.trailing.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func endEventView() {
        didEndEvent.backgroundColor = .gray
        didEndEvent.layer.borderWidth = 3
        didEndEvent.borderAndCorner(radius: 15, color: .black, width: 3)
        let image = UIImageView()
        image.image = UIImage(named: "endCalendar")
        image.contentMode = .scaleAspectFit
        let title = UILabel()
        title.textAlignment = .center
        title.text = "Ended Events"
        title.font = UIFont.boldSystemFont(ofSize: 10)
        title.textColor = .white
        didEndEvent.addSubview(image)
        image.snp.makeConstraints { (make) in
            make.height.width.equalTo(80)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
        didEndEvent.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.top.equalTo(image.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.trailing.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func createEventView() {
        createEvent.backgroundColor = .gray
        createEvent.layer.borderWidth = 3
        createEvent.borderAndCorner(radius: 15, color: .black, width: 3)
        let image = UIImageView()
        image.image = UIImage(named: "createCalendar")
        image.contentMode = .scaleAspectFit
        let title = UILabel()
        title.textAlignment = .center
        title.text = "Create Event"
        title.font = UIFont.boldSystemFont(ofSize: 10)
        title.textColor = .white
        createEvent.addSubview(image)
        image.snp.makeConstraints { (make) in
            make.height.width.equalTo(80)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
        createEvent.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.top.equalTo(image.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.trailing.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func setEndedLabel() {
        didEndEventLabel.textAlignment = .center
        didEndEventLabel.text = "Ended event counter Loading"
        didEndEventLabel.font = UIFont.boldSystemFont(ofSize: 20)
        didEndEventLabel.textColor = .black
        view.addSubview(didEndEventLabel)
        didEndEventLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
            make.height.equalTo(25)
        }
    }
    
    private func setUpcomingLabel() {
        upcomingLabel.textAlignment = .center
        upcomingLabel.text = "Upcoming event counter Loading"
        upcomingLabel.font = UIFont.boldSystemFont(ofSize: 20)
        upcomingLabel.textColor = .black
        view.addSubview(upcomingLabel)
        upcomingLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(45)
            make.height.equalTo(25)
        }
    }
    
    private func setStack() {
        let stackHorizontal = UIStackView()
        stackHorizontal.axis = .horizontal
        stackHorizontal.distribution = .fillEqually
        stackHorizontal.spacing = 10
        
        stackHorizontal.addArrangedSubview(comingEventView)
        stackHorizontal.addArrangedSubview(didEndEvent)
        
        let stackVertical = UIStackView()
        stackVertical.axis = .vertical
        stackVertical.distribution = .fillEqually
        stackVertical.spacing = 10
        
        stackVertical.addArrangedSubview(stackHorizontal)
        stackVertical.addArrangedSubview(createEvent)
        
        view.addSubview(stackVertical)
        stackVertical.snp.makeConstraints { (make) in
            make.height.equalTo(UIScreen.main.bounds.height*0.5)
            make.width.equalTo(UIScreen.main.bounds.width*0.7)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
        }
    }
    
}
