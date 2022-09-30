//
//  ViewController.swift
//  POCCompositionalLayout
//
//  Created by Bruno Barbosa on 28/09/22.
//

import UIKit

class MainViewController: UIViewController {

    private let mainView = MainView()

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }


}

