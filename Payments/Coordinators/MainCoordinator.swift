//
//  MainCoordinator.swift
//  Payments
//
//  Created by Vigen Simonyan on 2/22/21.
//

import UIKit

final class MainCoordinator: Coordinator {
    private(set) var childCordinators: [Coordinator] = []
    
    var window: UIWindow
    var didFinishMain: (() -> Void)?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let viewController: MainViewController = .instantiete()
        viewController.viewModel = PaymentViewModel()
        viewController.logoutTapped = { [weak self] in
            self?.didFinishMain?()
        }
        
        UIView.transition(with: self.window, duration: 0.5, options: [UIView.AnimationOptions.transitionFlipFromLeft], animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            UIApplication.shared.keyWindow?.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        })
    }
}
