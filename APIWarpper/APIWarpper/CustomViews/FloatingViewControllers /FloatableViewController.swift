//
//  FloatableViewController.swift
//  APIWarpper
//
//  Created by Talish George on 05/06/21.
//

import Foundation
import UIKit

public protocol Floatable: UIViewController {
    var floatingTopView: UIView? { get set }
    var floatingBottomView: UIView? { get set}
}

public extension Floatable {
    var floatingTopView: UIView? {
        get {
            floatableViewController?.floatingTopView }
        set {
            floatableViewController?.floatingTopView = newValue }
    }
    
    var floatingBottomView: UIView? {
        get {
            floatableViewController?.floatingBottomView }
        set {
            floatableViewController?.floatingBottomView = newValue }
    }
    
    private var floatableViewController: FloatableViewControllable? {
        guard let floatableViewController = parent as? FloatableViewControllable else {
            return nil
        }
        return floatableViewController
    }
}

public class FloatableViewcontroller<ViewControllerType: UIViewController>: UIViewController, FloatableViewControllable {
    
    public var viewController: ViewControllerType
    public var floatingTopView: UIView? {
        willSet {
            guard newValue != floatingTopView  else { return }
            removeFloatingView(floatingTopView, placement: .top)
        }
        didSet {
            guard oldValue != floatingTopView  else { return }
            addFloatingView(floatingTopView, placement: .top)
        }
    }
    
    public var floatingBottomView: UIView? {
        willSet {
            guard newValue != floatingBottomView  else { return }
            removeFloatingView(floatingBottomView, placement: .bottom)
        }
        didSet {
            guard oldValue != floatingBottomView  else { return }
            addFloatingView(floatingBottomView, placement: .bottom)
        }
    }
    
    public override var navigationItem: UINavigationItem {
        return viewController.navigationItem
    }
    
    // Mark: - Init
    
    public init() {
        viewController = ViewControllerType()
        super.init(nibName: nil, bundle: nil)
    }
    
    public init(viewcontroller: ViewControllerType) {
        self.viewController = viewcontroller
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError( "init(coder:) has not been initilized")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        addChild(viewController)
        viewController.didMove(toParent: self)
        view.addSubview(viewController.view)
    }
}

private protocol FloatableViewControllable: UIViewController {
    var floatingBottomView: UIView? { get set }
    var floatingTopView: UIView? { get set }
}

private extension FloatableViewcontroller {
    
    enum Placement {
        case top
        case bottom
        
        var edges: UIRectEdge {
            switch  self {
            case .top:
                return [.left,.top, .right]
            case .bottom:
                return [.left,.bottom, .right]
            }
        }
    }
    
    func removeFloatingView(_ floatingView: UIView?, placement: Placement) {
        if let floatingView = floatingView {
            DispatchQueue.main.async {
                floatingView.removeFromSuperview()
            }
        }
    }
    
    func addFloatingView(_ floatingView: UIView?, placement: Placement) {
        if let floatingView = floatingView {
            DispatchQueue.main.async {
                self.view.addSubview(floatingView)
                
                switch placement {
                case .top:
                    floatingView.anchor(top: self.view.topAnchor,
                                        left: self.view.leftAnchor,
                                        bottom: self.view.bottomAnchor,
                                        right: self.view.rightAnchor)
                case .bottom:
                    floatingView.anchor(left: self.view.leftAnchor,
                                        bottom: self.view.safeAreaLayoutGuide.bottomAnchor,
                                        right: self.view.rightAnchor,
                                        paddingLeft: 50,
                                        paddingBottom: 40,
                                        paddingRight: 50
                    )
                    floatingView.setHeight(height: 44)
                    floatingView.centerX(inView: self.view)
                }
            }
        }
    }
}

private extension UIViewController {
    var scrollView: UIScrollView? {
        if let scrollView = view as? UIScrollView {
            return scrollView
        }
        return nil
    }
}
