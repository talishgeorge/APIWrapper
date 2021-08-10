//
//  ScrollableStackView.swift
//  APIWarpper
//
//  Created by Talish George on 07/06/21.
//

import Foundation
import UIKit

class FSStackView: UIView {
    //initWithFrame to init view from code
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .lightGray
        return stackView
    }()

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
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setupLayout()
    }
    
    private func setupViews() {
        scrollView.backgroundColor = .lightGray
        self.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(stackView)
        
        for _ in 0...45 {
            stackView.addArrangedSubview(titleLabel)
        }
    }
    
    private func setupLayout() {

        scrollView.pinToSuperview(guide: .safeAreaGuide)
        contentView.pinToSuperview(guide: .none)
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        // for padding and spacing
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 40, leading: 16, bottom: 40, trailing: 16)
        stackView.pinToSuperview(guide: .none)
    }
}
