//
//  MainViewController.swift
//  SHIFT_iOS_TestTask
//
//  Created by Артём on 15.07.2025.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        super.viewDidLoad()
        showText()
    }
    
    func showText() {
        let label = UILabel()
        label.text = "Привет, как дела?"
        label.textAlignment = .center
        label.frame = view.bounds
        view.addSubview(label)
    }
}
