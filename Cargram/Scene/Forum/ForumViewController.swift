//
//  ForumViewController.swift
//  Cargram
//
//  Created by Ferhan Akkan on 14.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit

final class ForumViewController: BaseViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.backgroundColor = .white
        tableView.register(ForumCategoryTableViewCell.self, forCellReuseIdentifier: "ForumCategoryTableViewCell")
        return tableView
    }()
    
    let forumViewModel = ForumViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}

//MARK: - Setup UI

extension ForumViewController {
    private func setUI() {
        view.backgroundColor = .white
        setTableView()
    }
    
    private func setTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        tableView.dataSource = self
        tableView.delegate = self
    }
}

//MARK: - TableView Delegate & Datasource

extension ForumViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Categories"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forumViewModel.categoriesName.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        forumViewModel.setSelectedCategory(indexPath: indexPath.row)
        let vc = CategoryTopicsViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.show(vc, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForumCategoryTableViewCell", for: indexPath) as! ForumCategoryTableViewCell
        cell.categoryImageView.image = UIImage(named: forumViewModel.categoriesName[indexPath.row])
        cell.title.text = forumViewModel.categoriesName[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}
