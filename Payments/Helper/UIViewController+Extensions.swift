//
//  UIViewController+Extensions.swift
//  Payments
//
//  Created by Vigen Simonyan on 2/22/21.
//

import UIKit
import PKHUD

extension UIViewController {
    static func instantiete<T>() -> T {
        let storyBoard = UIStoryboard(name: "\(T.self)", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "\(T.self)") as! T
        return controller
    }
    
    func showProgress() {
        HUD.show(.progress)
    }
    
    func hideProgress() {
        HUD.hide()
    }
}


