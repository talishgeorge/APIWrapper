//
//  LoginController.swift
//  APIWarpper
//
//  Created by Talish George on 08/06/21.
//

import Foundation
import UIKit

class LoginController: UIViewController {
    
    // MARK :- Properties
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "TwitterLogo")
        iv.setDimensions(height: 100, width: 100)
        return iv
    }()
    
    private lazy var emailContainterView: UIView = {
        let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x")
        let view = Factories().makeInputContainerView(withImage: image, textField: emailTextField)
        return view
    }()
    
    private lazy var passwordContainterView: UIView = {
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x-1")
        let view = Factories().makeInputContainerView(withImage: image, textField: passwordTextField)
        return view
    }()
        
    private lazy var emailTextField: UITextField = {
        let tf = Factories().makeTextField(withPlaceholder: "Email")
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Factories().makeTextField(withPlaceholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        return button
    }()
    
    private var dontHaveAccountButton: UIButton = {
        let button = Factories().attributedButton(firstPart: "Dont have account?", secondPart: "SignUp")
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()

    // MARK :- Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        let fabContainer = FloatingView(buttonImage: #imageLiteral(resourceName: "icons8-plus-math-90"))
        view.addSubview(fabContainer)
        fabContainer.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                            right: view.rightAnchor,
                            paddingBottom: 20, paddingRight: 20)
        fabContainer.delegate = self
        
        fabContainer.addSecondaryButtonWith(image: #imageLiteral(resourceName: "firebase-logo"), labelTitle: "Twitter", action: {
            print("Twitter")
        })
        fabContainer.addSecondaryButtonWith(image: #imageLiteral(resourceName: "firebase-logo"), labelTitle: "Firebase", action: {
            print("Firebase")
        })
        fabContainer.addSecondaryButtonWith(image: #imageLiteral(resourceName: "firebase-logo"), labelTitle: "Google", action: {
            print("Google")
        })
        
        fabContainer.setFABButton()
    }
    
    // MARK :- Selectors
    
    @objc func handleSignUp() {
        print("user tapped dont have signup button")
    }
    
    private func configureUI() {
        
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        let scrollableView = ScrollableStackView()
        scrollableView.stackView.addArrangedSubview(logoImageView)
        scrollableView.stackView.addArrangedSubview(emailContainterView)
        scrollableView.stackView.addArrangedSubview(passwordContainterView)
        scrollableView.stackView.addArrangedSubview(loginButton)
        scrollableView.stackView.setCustomSpacing(30, after: passwordContainterView)
        scrollableView.stackView.isLayoutMarginsRelativeArrangement = true
        scrollableView.stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 16, bottom: 40, trailing: 16)
        view.addSubview(scrollableView)
        scrollableView.pinToSuperview(guide: .none)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: self.view.leftAnchor,
                            bottom: self.view.safeAreaLayoutGuide.bottomAnchor,
                                     right: self.view.rightAnchor)
    }
}

extension LoginController: FloatingSecondaryButtonDelegate {
    func secondaryActionForButton(_ action: FloatingSecondaryAction) {
        action()
    }
}
