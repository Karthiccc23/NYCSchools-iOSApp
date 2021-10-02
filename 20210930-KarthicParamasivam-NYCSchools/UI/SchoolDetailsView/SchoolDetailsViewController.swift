//
//  SchoolDetailsViewController.swift
//  20210930-KarthicParamasivam-NYCSchools
//
//  Created by Karthic Paramasivam on 10/1/21.
//

import Foundation
import UIKit

class SchoolDetailsViewController: UIViewController {
    var viewModel: SchoolDetailsViewModel
    
    let detailsNotAvailable: String = "Not Available"
        
    private let name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Not Available"
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.numberOfLines = 5
        return label
    }()
    
    private let summary: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Not Available"
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.numberOfLines = 30
        return label
    }()
    
    private let numOfTestTakers: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Not Available"
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.numberOfLines = 2
        return label
    }()
    
    private let satReadingScore: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Not Available"
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.numberOfLines = 2
        return label
    }()
    
    private let satMathScore: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Not Available"
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.numberOfLines = 2
        return label
    }()
    
    private let satWritingScore: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Not Available"
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.numberOfLines = 2
        return label
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 30
        return stackView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let mainView: UIView = {
        let mainView = UIView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        return mainView
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
    
    let details: [UILabel]
    
    
    init(viewModel: SchoolDetailsViewModel) {
        self.viewModel = viewModel
        self.details = [name,summary,numOfTestTakers,satReadingScore,satMathScore,satWritingScore]
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.getScreenTitle()
        self.view.backgroundColor = .white
        
        setUpUI()
        
        loadSchoolDetails()
    }
    
    
    func setUpUI() {
        view.addSubview(scrollView)
        view.addSubview(activityIndicator)
        scrollView.addSubview(mainView)
        mainView.addSubview(mainStackView)
                
        for i in 0..<viewModel.schoolDetailTitles.count {
            let stackView = createStackView()
            let labelsStackView = createLabelView(title: viewModel.schoolDetailTitles[i])
            mainStackView.addArrangedSubview(stackView)
            stackView.addArrangedSubview(labelsStackView)
            stackView.addArrangedSubview(details[i])
        }
        
        addConstraints()
    }
    
    func loadSchoolDetails() {
        activityIndicator.startAnimating()
        viewModel.fetchSchoolDetails() { [weak self] (completion, error) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.activityIndicator.stopAnimating()
                let schoolDetails = self.viewModel.schoolDetails
                guard error == nil, !schoolDetails.isEmpty
                else {
                    self.showAlert(error?.localizedDescription ?? "Cannot Connect to Server")
                    return
                }
                
                if completion {
                    for schoolDetail in schoolDetails {
                        self.name.text = schoolDetail.name
                        self.summary.text = self.viewModel.getSchoolSummary()
                        self.numOfTestTakers.text = schoolDetail.numOfTestTakers
                        self.satWritingScore.text = schoolDetail.satWritingScore
                        self.satMathScore.text = schoolDetail.satMathScore
                        self.satReadingScore.text = schoolDetail.satReadingScore
                    }
                }
            }
        }
    }

    func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }
    
    func createLabelView(title: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainStackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            mainStackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    func showAlert(_ errorMessage: String) {
    
        let alert = UIAlertController(title: "ERROR MESSAGE", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
}
