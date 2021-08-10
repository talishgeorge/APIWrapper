import UIKit

public protocol FloatingSecondaryButtonDelegate: class {
    func secondaryActionForButton(_ action: @escaping () -> ())
}

public typealias FloatingSecondaryAction = () -> ()

typealias FloatingSecondary = (title: String, image: UIImage, action: () -> ())

class FloatingSecondaryButton: UIView {
    
    private var secondaryButton = UIButton(frame: .zero)
    private var buttonLabel = FloatingInsetLabel(frame: .zero)
    private var labelView = UIView(frame: .zero)
    private var fabSecondary: FloatingSecondary!
    
    weak var delegate: FloatingSecondaryButtonDelegate?

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }

    init(fabSecondary: FloatingSecondary) {
         super.init(frame: .zero)
         self.fabSecondary = fabSecondary
         configure()
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        configureSecondaryButton()
        configureLabel()
        configureLayoutUI()
    }
    
    
    private func configureSecondaryButton() {
        secondaryButton.translatesAutoresizingMaskIntoConstraints = false
        secondaryButton.setImage(fabSecondary.image, for: .normal)
        secondaryButton.backgroundColor = UIColor.white
        secondaryButton.layer.cornerRadius = 17
        secondaryButton.addTarget(self, action: #selector(secondaryButtonAction), for: .touchUpInside)
        
        dropShadowToView(secondaryButton)
    }
    
    
    @objc private func secondaryButtonAction() {
        delegate?.secondaryActionForButton(fabSecondary.action)
    }
    
    
    private func configureLabel() {
        labelView.backgroundColor = .clear
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.layer.cornerRadius = 4
        dropShadowToView(labelView)

        buttonLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonLabel.font = .systemFont(ofSize: 14)
        buttonLabel.textAlignment = .center
        buttonLabel.text = fabSecondary.title
        buttonLabel.textColor = .white
        buttonLabel.contentInsets = UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 7)
    }

    
    private func configureLayoutUI() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(labelView)
        labelView.addSubview(buttonLabel)
        addSubview(secondaryButton)
        
        secondaryButton.anchor(right: rightAnchor,
                               paddingRight: 10, width: 34, height: 34)
        labelView.anchor(left: buttonLabel.leftAnchor, right: secondaryButton.leftAnchor,
                               paddingRight: 5, height: 27)
        buttonLabel.anchor(top: labelView.topAnchor,  bottom: labelView.bottomAnchor,
                           right: labelView.rightAnchor)
    }
    
    private func dropShadowToView(_ view: UIView) {
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        view.layer.shadowRadius = 4.0
        view.layer.shadowOpacity = 0.4
    }
}

