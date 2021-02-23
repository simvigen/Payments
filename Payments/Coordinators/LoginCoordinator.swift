//
//  LoginCoordinator.swift
//  Payments
//
//  Created by Vigen Simonyan on 2/22/21.
//

import UIKit

final class LoginCoordinator: Coordinator {
    private(set) var childCordinators: [Coordinator] = []
    
    var window: UIWindow
    var didFinishLogin: (() -> Void)?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let viewController: LoginViewController = .instantiete()
        viewController.viewModel = LoginViewModel()
        viewController.loginDone = { [weak self] in
            self?.didFinishLogin?()
        }
        
        UIView.transition(with: window, duration: 0.5, options: [UIView.AnimationOptions.transitionCrossDissolve], animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            UIApplication.shared.keyWindow?.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        })
    }
}
