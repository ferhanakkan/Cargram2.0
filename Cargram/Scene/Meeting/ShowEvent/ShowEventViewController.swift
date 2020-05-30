//
//  ShowEventViewController.swift
//  Cargram
//
//  Created by Ferhan Akkan on 29.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit

enum EventType {
    case endedEvent
    case upComingEvent
}

class ShowEventViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.backgroundColor = .white
        tableView.register(LikeTableViewCell.self, forCellReuseIdentifier: "LikeTableViewCell")
        return tableView
    }()
    
    let searchTextfield = UITextField()
    let searchImage = UIImageView()
    let searchMainView = UIView()
    let searchView = UIView()
    let showInMapButton = UIButton()
    var selectedType: EventType = .upComingEvent
    
    let showEventViewModel = ShowEventViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}

//MARK: - Set UI

extension ShowEventViewController {
    
    private func setUI() {
        view.backgroundColor = .white
        setSearchBar()
        setTableView()
        selectedType == .upComingEvent ? setShowEventButton() : nil
    }
    
    private func setSearchBar() {
        view.addSubview(searchMainView)
        searchMainView.backgroundColor = .white
        searchMainView.addSubview(searchView)
        searchView.backgroundColor = .gray
        searchView.cornerRadius = 15
        searchView.addSubview(searchImage)
        searchView.addSubview(searchTextfield)
        searchMainView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(70)
            make.leading.trailing.equalToSuperview()
        }
        
        searchView.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(5)
            make.bottom.trailing.equalToSuperview().inset(5)
        }
        
        searchImage.image = UIImage(named: "search")
        searchImage.contentMode = .scaleToFill
        searchImage.snp.makeConstraints { (make) in
            make.height.width.equalTo(50)
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
        
        searchTextfield.placeholder = "Search Prefered event"
        searchTextfield.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(searchImage.snp.leading).offset(10)
        }
    }
    
    private func setTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(searchView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            (selectedType == .endedEvent) ?  (make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)) : nil
        }
    }
    
    private func setShowEventButton() {
        showInMapButton.setTitle("Show In Map", for: .normal)
        showInMapButton.backgroundColor = .gray
        view.addSubview(showInMapButton)
        showInMapButton.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.top.equalTo(tableView.snp.bottom)
            make.height.equalTo(50)
        }
    }
    
}
