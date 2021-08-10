//
//  FeedController.swift
//  APIWarpper
//
//  Created by Talish George on 18/01/21.
//

import Foundation
import UIKit

class FeedController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.pushViewController(FloatableViewcontroller<FloatingViewController>(), animated: false)
    }
}
