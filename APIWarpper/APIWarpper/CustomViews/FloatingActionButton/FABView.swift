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
        isMenuOnScreen ? stackView.dismissButtons() : stackView.showButtons()
        isMenuOnScreen.toggle()
    }
    
    
    private func layoutUI() {
        addArrangedSubview(stackView)
        addArrangedSubview(mainButton)

        NSLayoutConstraint.activate([
            mainButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainButton.widthAnchor.constraint(equalToConstant: 50),
            mainButton.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 150)
        ])
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
