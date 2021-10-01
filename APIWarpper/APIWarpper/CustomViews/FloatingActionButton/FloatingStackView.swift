
import UIKit

class FloatingStackView: UIStackView {
    
    private var fabSecondaryButtons: [FloatingSecondary] = [FloatingSecondary]()
    private var secondaryButtons: [UIView] = [UIView]()
    private var secondaryViews: [UIView] = [UIView]()
    var mainButton: FloatingMainButton? = nil
    var delay = 0.15
    var index = 0
    var itemOffset = -55
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
        
        self.addArrangedSubview(view)
        view.anchor(left: self.leftAnchor, right: self.rightAnchor, height: 54)
        
        let offset = CGPoint(x: 0, y: mainButton!.center.y)
        view.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
        view.alpha = 0
        UIView.animate(
            withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 2,
          options: .curveEaseOut, animations: {
            view.transform = .identity
            view.alpha = 1
            self.showButtons()
          }, completion: nil)
        
//        view.alpha = 0
//        UIView.animate(withDuration: 0.3, animations: { () -> Void in
//            view.alpha = 1
//            self.showButtons()
//        })
        
        /*
        view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        UIView.animate(
            withDuration: 0.5, delay: delay, usingSpringWithDamping: 0.55, initialSpringVelocity: 3,
          options: .curveEaseOut, animations: {
            view.transform = .identity
            view.alpha = 1
            self.showButtons()
          }, completion: nil)
        */
        
//        if let mainButton = mainButton {
//        view.frame = CGRect(x: mainButton.frame.origin.x, y: mainButton.frame.origin.y - mainButton.frame.height * CGFloat(index), width: mainButton.frame.width, height: mainButton.frame.height)
//        }
//            UIView.animate(withDuration: 0.2, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIView.AnimationOptions(), animations: { [self] in
//                let shift = view.frame.height
//                view.transform = CGAffineTransform.init(translationX: 0, y:  -shift)
//                view.alpha = 1
//                showButtons()
//            }, completion: nil)
//        delay += 0.15
//        index += 1
//        //}
    
//        view.alpha = 0
//        UIView.animate(withDuration: 0.6, animations: { () -> Void in
//          view.alpha = 1
//            self.showButtons()
//        })
        
        
//        view.transform = CGAffineTransform(scaleX: 0, y: 0)
//
//        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseIn], animations: {
//            view.transform  = .identity
//            self.showButtons()
//        })
        
//        UIView.animate(withDuration: 0.01, delay: 0.01, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: UIView.AnimationOptions.allowAnimatedContent, animations: {
//            view.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 0.99)
//        }, completion: {completed in
//            self.showButtons()
//        })

//        view.transform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
//            UIView.animate(withDuration: 0.075, animations: {
//                view.transform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
//            }) { finished in
//                UIView.animate(withDuration: 0.03, animations: {
//                    view.transform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
//                }) { finished in
//                    UIView.animate(withDuration: 0.03, animations: {
//                        view.transform = CGAffineTransform.identity
//                    }) { finished in
//                        self.showButtons()
//                    }
//                }
//            }
        
    }
    
   
    func dismissButtons() {
        guard let view = secondaryButtons.last else {
            setSecondaryButtonsArray()
            return
        }
        
        secondaryButtons.removeLast()
        
//        UIView.animate(withDuration: 0.075, animations: {
//            view.transform = CGAffineTransform.identity.scaledBy(x: 0.0, y: 0.1)
//        }) { finished in
//            view.removeFromSuperview()
//            self.dismissButtons()
//        }
//
//        UIView.animate(withDuration: 0.075, animations: {
//                view.transform = CGAffineTransform.identity.scaledBy(x: 0.001, y: 0.001)
//            }) { finished in
//                view.removeFromSuperview()
//                self.dismissButtons()
//            }
        
        view.alpha = 1
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            view.alpha = 0
        }) { finished in
            view.removeFromSuperview()
            self.dismissButtons()
        }
        
//        let offset = CGPoint(x: 0, y: view.center.y)
//        view.transform = .identity
//        UIView.animate(
//            withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 2,
//            options: .curveEaseOut, animations: {
//                view.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
//            }) {_ in
//            view.alpha = 0
//            view.removeFromSuperview()
//            self.dismissButtons()
//        }
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
