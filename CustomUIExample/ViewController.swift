//
//  ViewController.swift
//  CustomUIExample
//
//  Created by Leo Ho on 2022/12/18.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var checkBox: CheckBox!
    
    // MARK: - Variables
    
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Settings

    func setupUI() {
        checkBox.setInit(buttonTag: 0, text: "點我", isChecked: false, delegate: self)
    }
}

// MARK: - Extensions

extension ViewController: CheckBoxDelegate {
    
    func checkBox(_ checkBox: CheckBox, didTappedAt index: Int) {
        print("CheckBox 被點擊了")
    }
}

// MARK: - Protocol

