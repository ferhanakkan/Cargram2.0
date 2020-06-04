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
    
    override func viewWillAppear(_ animated: Bool) {
        setEventLabels()
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
        title.font = UIFont.boldSystemFont(ofSize: 30)
        title.adjustsFontSizeToFitWidth = true
        title.minimumScaleFactor = 0.3
        title.textColor = .white
        comingEventView.addSubview(image)
        image.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.greaterThanOrEqualTo(10)
        }
        comingEventView.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.top.equalTo(image.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.trailing.bottom.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
        let gest = UITapGestureRecognizer(target: self, action: #selector(upcomingPressed))
        comingEventView.addGestureRecognizer(gest)
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
        title.font = UIFont.boldSystemFont(ofSize: 30)
        title.adjustsFontSizeToFitWidth = true
        title.minimumScaleFactor = 0.3
        title.textColor = .white
        didEndEvent.addSubview(image)
        image.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.greaterThanOrEqualTo(10)
        }
        didEndEvent.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.top.equalTo(image.snp.bottom)
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(10)
            make.trailing.bottom.equalToSuperview().inset(10)
        }
        let gest = UITapGestureRecognizer(target: self, action: #selector(endedEventPressed))
        didEndEvent.addGestureRecognizer(gest)
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
        title.font = UIFont.boldSystemFont(ofSize: 30)
        title.minimumScaleFactor = CGFloat(0.3)
        title.textColor = .white
        createEvent.addSubview(image)
        image.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.greaterThanOrEqualTo(10)
        }
        createEvent.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.top.equalTo(image.snp.bottom)
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(10)
            make.trailing.bottom.equalToSuperview().inset(10)
        }
        
        let gest = UITapGestureRecognizer(target: self, action: #selector(createPressed))
        createEvent.addGestureRecognizer(gest)
    }
    
    private func setEndedLabel() {
        didEndEventLabel.textAlignment = .center
        didEndEventLabel.text = "Ended event counter Loading"
        didEndEventLabel.font = UIFont.boldSystemFont(ofSize: 40)
        didEndEventLabel.adjustsFontSizeToFitWidth = true
        didEndEventLabel.minimumScaleFactor = 0.2
        didEndEventLabel.textColor = .black
        view.addSubview(didEndEventLabel)
        didEndEventLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
        }
    }
    
    private func setUpcomingLabel() {
        upcomingLabel.textAlignment = .center
        upcomingLabel.text = "Upcoming event counter Loading"
        upcomingLabel.font = UIFont.boldSystemFont(ofSize: 40)
        upcomingLabel.adjustsFontSizeToFitWidth = true
        upcomingLabel.minimumScaleFactor = 0.2
        upcomingLabel.textColor = .black
        view.addSubview(upcomingLabel)
        upcomingLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.bottom.equalTo(didEndEventLabel.snp.top).offset(-10)
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
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
        }
    }
    
}


//MARK: - Core Location

extension MeetingViewController {
    
    @objc func upcomingPressed() {
        let vc = ShowEventViewController()
        vc.selectedType = .upComingEvent
        vc.hidesBottomBarWhenPushed = true
        vc.showEventViewModel.eventArray = meetingViewModel.upcomingArray
        navigationController?.show(vc, sender: nil)
    }
    
    @objc func endedEventPressed() {
        let vc = ShowEventViewController()
        vc.selectedType = .endedEvent
        vc.showEventViewModel.eventArray = meetingViewModel.endedArray
        vc.hidesBottomBarWhenPushed = true
        navigationController?.show(vc, sender: nil)
    }
    
    @objc func createPressed() {
        let vc = CreateMeetingViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.show(vc, sender: nil)
    }
}

//MARK: - Actions

extension MeetingViewController {
    
    private func setEventLabels() {
        meetingViewModel.fetchData { [unowned self] (_, err) in
            if let error = err {
                LoadingView.hide()
                AppManager.shared.messagePresent(title: "OOPS", message: error.localizedDescription, type: .error, isInternet: .nonInternetAlert)
            }
            
            DispatchQueue.main.async {
                self.upcomingLabel.text = self.meetingViewModel.getUpcomingLabel()
                self.didEndEventLabel.text = self.meetingViewModel.getEndedLabel()
                LoadingView.hide()
            }
        }
    }
}
