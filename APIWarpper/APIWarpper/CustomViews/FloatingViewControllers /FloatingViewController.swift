//
//  FloatableViewController.swift
//  APIWarpper
//
//  Created by Talish George on 07/06/21.
//

import Foundation
import UIKit

class FloatingViewController: UIViewController, Floatable {
    var showLargeTitle: Bool = false
    private lazy var sampleView: UIView = {
        let view = FSStackView()
        return view
    }()
    
    private lazy var buttonView: UIView = {
        let buttonView = UIButton()
        buttonView.backgroundColor = .orange
        buttonView.setTitle("Test Button", for: .normal)
        buttonView.pinToSuperview(guide: .safeAreaGuide)
        return buttonView
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        floatingTopView = sampleView
        floatingBottomView = buttonView
    }
}
