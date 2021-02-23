//
//  AppCoordinator.swift
//  Payments
//
//  Created by Vigen Simonyan on 2/22/21.
//

import UIKit
import Moya

protocol Coordinator: AnyObject {
    var childCordinators: [Coordinator] { get }
    func start()
}

final class AppCoordinator: Coordinator {
    private(set) var childCordinators: [Coordinator] = []
    
    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        window.makeKeyAndVisible()
        (PaymentsAPI.token == nil) ? goLoginPage() : goMainPage()
    }
    
    private func goLoginPage() {
        let loginCordinator = LoginCoordinator(window: window)
        loginCordinator.didFinishLogin = { [weak self] in
            guard let self = self else { return }
            
            if let index = self.childCordinators.firstIndex(where: { $0 === loginCordinator }) {
                self.childCordinators.remove(at: index)
            }
            self.goMainPage()
        }
        loginCordinator.start()
        childCordinators.append(loginCordinator)
    }
    
    private func goMainPage() {
        let mainCordinator = MainCoordinator(window: window)
        mainCordinator.didFinishMain = { [weak self] in
            guard let self = self else { return }
            
            PaymentsAPI.token = nil
            if let index = self.childCordinators.firstIndex(where: { $0 === mainCordinator }) {
                self.childCordinators.remove(at: index)
            }
            
            self.goLoginPage()
        }
        mainCordinator.start()
        childCordinators.append(mainCordinator)
    }
}
