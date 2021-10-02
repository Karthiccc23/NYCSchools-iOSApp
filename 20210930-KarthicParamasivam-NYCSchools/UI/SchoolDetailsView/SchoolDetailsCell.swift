//
//  SchoolDetailsCell.swift
//  20210930-KarthicParamasivam-NYCSchools
//
//  Created by Karthic Paramasivam on 10/1/21.
//

import Foundation
import UIKit


class SchoolDetailsCell: UITableViewCell {
    var schoolDetails : SchoolDetailsCellViewModel? {
        didSet {
            title.text = schoolDetails?.title
            subtitle.text = schoolDetails?.subtitle
        }
    }
    
    private let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let subtitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.numberOfLines = 2
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.axis = .vertical
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
        contentView.addSubview(title)
        contentView.addSubview(subtitle)
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(subtitle)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 5),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
        ])
    }
}

final class SchoolDetailsCellViewModel {
    let title: String
    let subtitle: String
    
    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
}
