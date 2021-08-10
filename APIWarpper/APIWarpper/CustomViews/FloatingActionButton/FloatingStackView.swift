
import UIKit

class FloatingStackView: UIStackView {
    
    private var fabSecondaryButtons: [FloatingSecondary] = [FloatingSecondary]()
    private var secondaryButtons: [UIView] = [UIView]()
    private var secondaryViews: [UIView] = [UIView]()
    
    weak var delegate: FloatingSecondaryButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureStackView() {
        translatesAutoresizingMaskIntoConstraints = false
        distribution = .fill
        axis = .vertical
        alignment = .trailing
        spacing = 12
        clipsToBounds = true
    }
    
    private func configureSecondaryButtons() {
        
        for secondary in fabSecondaryButtons {
            let secondaryView = FloatingSecondaryButton(fabSecondary: secondary)
            secondaryView.delegate = self
            secondaryViews.append(secondaryView)
        }
        setSecondaryButtonsArray()
    }
    
    private func setSecondaryButtonsArray() {
        for view in secondaryViews {
            secondaryButtons.append(view)
        }
    }
}

// MARK: - Public methods
extension FloatingStackView {
    func addSecondaryButtonWith(image: UIImage, labelTitle: String, action: @escaping () -> ()) {
        let component: FloatingSecondary
        component.image = image
        component.title = labelTitle
        component.action = action
        fabSecondaryButtons.append(component)
    }
    
    func setFABButton() {
        configureSecondaryButtons()
    }
    
    func showButtons() {
        
        guard let view = secondaryButtons.last else {
            setSecondaryButtonsArray()
            return
        }
        
        secondaryButtons.removeLast()
        
        addArrangedSubview(view)
        
        view.anchor(left: leftAnchor, right: rightAnchor, height: 34)
        UIView.animate(withDuration: 0.01, delay: 0.01, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: UIView.AnimationOptions.allowAnimatedContent, animations: {
            view.transform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
        }, completion: {completed in
            self.showButtons()
        })
    }
    
    func dismissButtons() {
        guard let view = secondaryButtons.last else {
            setSecondaryButtonsArray()
            return
        }
        
        secondaryButtons.removeLast()
        
        UIView.animate(withDuration: 0.075, animations: {
            view.transform = CGAffineTransform.identity.scaledBy(x: 0.0, y: 0.1)
        }) { finished in
            view.removeFromSuperview()
            self.dismissButtons()
        }
    }
}

extension FloatingStackView: FloatingSecondaryButtonDelegate {
    func secondaryActionForButton(_ action: @escaping () -> ()) {
        delegate?.secondaryActionForButton(action)
        dismissButtons()
    }
}

extension UIStackView {
    func removeAllSubviews() {
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
    }
}
