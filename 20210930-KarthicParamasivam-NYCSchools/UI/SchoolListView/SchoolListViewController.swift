//
//  SchoolListViewController.swift
//  20210930-KarthicParamasivam-NYCSchools
//
//  Created by Karthic Paramasivam on 10/1/21.
//

import Foundation
import UIKit


class SchoolListViewController: UIViewController {
    
    private var viewModel: SchoolListViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SchoolListCell.self, forCellReuseIdentifier: "cell1")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    init(viewModel: SchoolListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = viewModel.getScreenTitle()
        
        setUpUI()
        
        loadSchools()
    }
    
    func setUpUI() {
        view.addSubview(tableView)
        addConstraints()
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func loadSchools() {
        viewModel.fetchSchools() { [weak self] completion in
            if completion {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
}

extension SchoolListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.schools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !viewModel.schools.isEmpty else { return UITableViewCell() }
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as? SchoolListCell {
            let school = viewModel.schools[indexPath.row]
            cell.school = school
            return cell
        }
        return UITableViewCell()
    }
}
