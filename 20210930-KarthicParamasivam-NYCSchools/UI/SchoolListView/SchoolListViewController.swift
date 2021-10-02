//
//  SchoolListViewController.swift
//  20210930-KarthicParamasivam-NYCSchools
//
//  Created by Karthic Paramasivam on 10/1/21.
//

import Foundation
import UIKit
import Network


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
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .large
        activityIndicator.layer.cornerRadius = 10
        let transform: CGAffineTransform = CGAffineTransform(scaleX: 3.5, y: 3.5)
        activityIndicator.transform = transform
        activityIndicator.layer.borderColor = UIColor.black.cgColor
        activityIndicator.backgroundColor = UIColor.white
        return activityIndicator
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
        
        NetworkMonitor.shared.connectionObserver = self
        
        setUpUI()
        
        loadSchools()
    }
    
    func setUpUI() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        addConstraints()
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    func loadSchools() {
        activityIndicator.startAnimating()
        viewModel.fetchSchools() { [weak self] completion in
            if completion {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.activityIndicator.stopAnimating()
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension SchoolListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let listCount = viewModel.schools.count
        
        if !NetworkMonitor.shared.isInternetOn {
            self.tableView.setEmptyMessage("Please Check Internet Connection")
        } else if listCount == 0 {
            self.tableView.setEmptyMessage("No Schools Found")
        }
        return listCount
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !viewModel.schools.isEmpty else { return }
        let school = viewModel.schools[indexPath.row]
        viewModel.showSchoolDetails(for: school)
    }
}

extension SchoolListViewController: ConnectionObserver {
    func connectionStateDidChange(internetOn: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}


extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
}

