//
//  SchoolListCell.swift
//  20210930-KarthicParamasivam-NYCSchools
//
//  Created by Karthic Paramasivam on 10/1/21.
//

import Foundation
import UIKit

class SchoolListCell: UITableViewCell {
    
    var school : School? {
        didSet {
            let websiteUrl: String = school?.website ?? ""
            name.text = school?.name
            website.text = websiteUrl
            phoneNumber.text = school?.phoneNumber
            location.text = school?.location
            totalStudents.text = school?.totalStudents
            summary.text = school?.summary
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapSchoolLink(_:)))
            website.addGestureRecognizer(tapGesture)
        }
    }
    
    private let name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let website: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        label.attributedText = NSAttributedString(string: "www.underline.com", attributes:
            [.underlineStyle: NSUnderlineStyle.single.rawValue])
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private let location: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.numberOfLines = 2
        return label
    }()
    
    private let studentsEnrolled: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Students enrolled:"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let totalStudents: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.numberOfLines = 2
        return label
    }()
    
    private let summary: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.numberOfLines = 2
        return label
    }()
    
    private let phoneNumber: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        return label
    }()
    
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        contentView.addSubview(name)
        contentView.addSubview(website)
        contentView.addSubview(location)
        contentView.addSubview(stackView)
        contentView.addSubview(phoneNumber)
        stackView.addArrangedSubview(studentsEnrolled)
        stackView.addArrangedSubview(totalStudents)
        contentView.addSubview(summary)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            name.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 5),
            name.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            
            summary.topAnchor.constraint(equalTo: name.bottomAnchor,constant: 5),
            summary.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 5),
            summary.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            summary.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.topAnchor.constraint(equalTo: summary.bottomAnchor, constant: 5),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 5),
            stackView.heightAnchor.constraint(equalToConstant: 30),
            
            location.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 5),
            location.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 5),
            location.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            location.heightAnchor.constraint(equalToConstant: 50),
            
            phoneNumber.topAnchor.constraint(equalTo: location.bottomAnchor, constant: 5),
            phoneNumber.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 5),
            phoneNumber.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            phoneNumber.heightAnchor.constraint(equalToConstant: 30),
            
            website.topAnchor.constraint(equalTo: phoneNumber.bottomAnchor, constant: 5),
            website.leftAnchor.constraint(equalTo: leftAnchor,constant: 5),
            website.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            website.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            website.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    @objc
    func tapSchoolLink(_ gesture: UITapGestureRecognizer) {
        guard let label = gesture.view as? UILabel, let websiteLink = label.text else { return }
        if let url = URL(string: "https://\(websiteLink)") {
            UIApplication.shared.open(url)
        }
    }
}
