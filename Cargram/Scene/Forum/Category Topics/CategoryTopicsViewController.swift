//
//  CategoryTopicsViewController.swift
//  Cargram
//
//  Created by Ferhan Akkan on 15.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit

final class CategoryTopicsViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.backgroundColor = .white
        tableView.register(CategoryEmptyTableViewCell.self, forCellReuseIdentifier: "CategoryEmptyTableViewCell")
        tableView.register(CategoryTopicTableViewCell.self, forCellReuseIdentifier: "CategoryTopicTableViewCell")
        return tableView
    }()
    
    let categoryTopicsViewModel = CategoryTopicsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        categoryTopicsViewModel.getSelectedTopicDatas { (_) in
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newTitleButtonPressed))
    }
    
    @objc private func newTitleButtonPressed() {
        let vc = NewTopicViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc,animated: true)
    }
}

//MARK: - Setup UI

extension CategoryTopicsViewController {
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

extension CategoryTopicsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if categoryTopicsViewModel.topicsModel.count == 0 {
            return 1
        } else {
            return categoryTopicsViewModel.topicsModel.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        categoryTopicsViewModel.setSelectedCategory(indexPath: indexPath.row)
        let vc = MessageViewController()
        navigationController?.show(vc, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if categoryTopicsViewModel.topicsModel.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryEmptyTableViewCell", for: indexPath) as! CategoryEmptyTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTopicTableViewCell", for: indexPath) as! CategoryTopicTableViewCell
            cell.title.text = categoryTopicsViewModel.topicsModel[indexPath.row].title
            cell.subTitle.text = categoryTopicsViewModel.topicsModel[indexPath.row].subTitle
            cell.accessoryType = .disclosureIndicator
            return cell

        }
    }
    
    
}
