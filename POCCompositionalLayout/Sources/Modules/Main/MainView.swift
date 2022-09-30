//
//  MainView.swift
//  POCCompositionalLayout
//
//  Created by Bruno Barbosa on 29/09/22.
//

import UIKit

class MainView: UIView {

    // MARK: - Private properties

    private let mainLabel = UILabel()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViewCode()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViewCode()
    }
}

// MARK: - View Code

extension MainView {

    private func setupViewCode() {
        buildHierarchy()
        setupConstraints()
        configureViews()
    }

    private func buildHierarchy() {
        addSubview(mainLabel)
    }

    private func setupConstraints() {
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            mainLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
    }

    private func configureViews() {
        mainLabel.text = "Hello World"
    }
}

