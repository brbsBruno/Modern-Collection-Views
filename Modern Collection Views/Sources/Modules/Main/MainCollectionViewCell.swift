//
//  MainCollectionViewCell.swift
//  Modern Collection Views
//
//  Created by Bruno Barbosa on 03/10/22.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    // MARK: - Public properties

    static let identifier = "main-collection-view-cell-reuse-identifier"

    // MARK: - UI elements
    
    let label = UILabel()

    // MARK: - Initialisers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCode()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViewCode()
    }
}

extension MainCollectionViewCell {

    private func setupViewCode() {
        buildHierarchy()
        setupConstraints()
        configureViews()
    }

    private func buildHierarchy() {
        contentView.addSubview(label)
    }

    private func setupConstraints() {
        let inset = CGFloat(10)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])
    }

    private func configureViews() {
        contentView.backgroundColor = .gray
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 8

        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .black
        label.textAlignment = .center
    }
}
