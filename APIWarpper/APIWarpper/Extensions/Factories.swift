//
//  Factories.swift
//  APIWarpper
//
//  Created by Talish George on 07/06/21.
//

import Foundation
import UIKit

class Factories {
    
    // MARK: - Labels
    
    func makeLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false // important!
        label.backgroundColor = .yellow
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = text
        
        return label
    }
    
    func makeLabel(withText text: String, size: CGFloat) -> UILabel {
        let label = makeLabel(withText: text)
        label.font = UIFont.systemFont(ofSize: size)
        
        return label
    }
    
    func makeLabel(withText text: String, size: CGFloat, color: UIColor) -> UILabel {
        let label = makeLabel(withText: text, size: size)
        label.backgroundColor = color
        
        return label
    }
    
    func makeSecondaryLabel(withText text: String) -> UILabel {
        let label = makeLabel(withText: text, size: 12)
        label.textColor = .gray
        
        return label
    }
    
    // MARK: - Buttons
    
    func makeButton(withText text: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(text, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        button.backgroundColor = .blue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        
        return button
    }
    
    func makeButton(withText text: String, size: CGFloat = 18, color: UIColor = .blue) -> UIButton {
        let button = makeButton(withText: text)
        button.backgroundColor = color
        button.titleLabel?.font = UIFont.systemFont(ofSize: size)
        
        return button
    }
    
    func makeButton(withText text: String, color: UIColor) -> UIButton {
        let button = makeButton(withText: text)
        button.backgroundColor = color
        
        return button
    }
    
    // MKAR: - Misc
    
    func makeTextField(withPlaceholderText placeHolderText: String) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = placeHolderText
        textField.backgroundColor = .orange
        
        return textField
    }
    
    func makeStackView(withOrientation axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8.0
        
        return stackView
    }
    
    func makeView(color: UIColor = .red) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = color
        
        return view
    }
    
    func makeInputContainerView(withImage image: UIImage, textField: UITextField) -> UIView {
        let view = UIView()
        view.setHeight(height: 50)
        let iv = UIImageView()
        iv.image = image
        iv.setDimensions(height: 24, width: 24)
        view.addSubview(iv)
        iv.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, paddingLeft: 0, paddingBottom: 10)
        view.addSubview(textField)
        textField.anchor(left:iv.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 0, paddingBottom: 10)
        
        let dividerView = UIView()
        view.addSubview(dividerView)
        dividerView.setHeight(height: 0.75)
        dividerView.backgroundColor = .white
        dividerView.anchor(left: iv.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        return view
    }
    
    func makeTextField(withPlaceholder placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        tf.textColor = .white
        tf.tintColor = .white
        tf.setLeftPaddingPoints(10)
        return tf
    }
    
    func makeSwitch(isOn: Bool) -> UISwitch {
        let theSwitch = UISwitch()
        theSwitch.translatesAutoresizingMaskIntoConstraints = false
        theSwitch.isOn = isOn
        
        return theSwitch
    }
    
    func makeScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }
    
    public func makeSpacerView(height: CGFloat? = nil) -> UIView {
        let spacerView = UIView(frame: .zero)
        
        if let height = height {
            spacerView.heightAnchor.constraint(equalToConstant: height).setActiveBreakable()
        }
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        
        return spacerView
    }
    
    func attributedButton(firstPart: String, secondPart: String) -> UIButton {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: firstPart, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white])
        
        attributedTitle.append(NSMutableAttributedString(string: secondPart, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }
    
    var titleLabel: UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "UIStackView inside UIScrollView."
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        label.setHeight(height: 44)
        label.backgroundColor = .white
        return label
    }
}

public extension NSLayoutConstraint {
    @objc func setActiveBreakable(priority: UILayoutPriority = UILayoutPriority(900)) {
        self.priority = priority
        isActive = true
    }
}

extension UIColor {
    static let darkBlue = UIColor(red: 10/255, green: 132/255, blue: 255/255, alpha: 1)
    static let darkGreen = UIColor(red: 48/255, green: 209/255, blue: 88/255, alpha: 1)
    static let darkOrange = UIColor(red: 255/255, green: 149/255, blue: 0/255, alpha: 1)
    static let darkRed = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1)
    static let darkTeal = UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 1)
    static let darkYellow = UIColor(red: 255/255, green: 204/255, blue: 0/255, alpha: 1)
}
