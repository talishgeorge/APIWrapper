import UIKit

public class FloatingView: UIStackView {
    
    private let stackView = FloatingStackView(frame: .zero)
    private var mainButton = FloatingMainButton(frame: .zero)
    private var isMenuOnScreen: Bool = false
    
    weak public var delegate: FloatingSecondaryButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    public init(buttonImage: UIImage?) {
        super.init(frame: .zero)
        
        mainButton.setImage(buttonImage, for: .normal)
        mainButton.addTarget(self, action: #selector(mainButtonAction), for: .touchUpInside)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        configureContainer()
        layoutUI()
    }
    
    private func configureContainer() {
        translatesAutoresizingMaskIntoConstraints = false
        distribution = .fill
        axis = .vertical
        alignment = .trailing
        spacing = 16
        clipsToBounds = true
        stackView.delegate = self
    }
    
    @objc private func mainButtonAction() {
        
        if isMenuOnScreen {
            UIView.animate(withDuration: 0.3) { [self] in
                self.mainButton.layer.transform = CATransform3DMakeRotation(0, 0.0, 0.0, 1)
                
                //        self.overLayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            }
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.mainButton.layer.transform = CATransform3DMakeRotation(CGFloat(-M_PI_4), 0.0, 0.0, 1)                //self.overLayView.backgroundColor = UIColor.black.withAlphaComponent(0.0)
            })
        }
        
        isMenuOnScreen ? stackView.dismissButtons() : stackView.showButtons()
        isMenuOnScreen.toggle()
    }
    
    private func layoutUI() {
        stackView.mainButton = mainButton
        addArrangedSubview(stackView)
        addArrangedSubview(mainButton)

        stackView.anchor(top: topAnchor, left: leftAnchor, width: 150)
        mainButton.anchor( bottom: bottomAnchor, right: rightAnchor, width: 50, height: 50)
    }
}

public extension FloatingView {
    func addSecondaryButtonWith(image: UIImage, labelTitle: String, action: @escaping () -> ()) {
        stackView.addSecondaryButtonWith(image: image, labelTitle: labelTitle, action: action)
    }
     
    func setFABButton() {
        stackView.setFABButton()
    }
}

extension FloatingView: FloatingSecondaryButtonDelegate {
    public func secondaryActionForButton(_ action: @escaping () -> ()) {
        isMenuOnScreen.toggle()
        delegate?.secondaryActionForButton(action)
    }
}
