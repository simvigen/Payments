//
//  LoginViewController.swift
//  Payments
//
//  Created by Vigen Simonyan on 2/21/21.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    var loginDone: (() -> Void)?
    var viewModel: LoginViewModelProtocol!
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginTextFeild: UITextField!
    @IBOutlet weak var passwordTextFeild: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindTextFieldToButton()
        bindResponse()
        bindHUD()

        NotificationCenter.default.rx.notification(UITextField.textDidChangeNotification).subscribe(onNext: { _ in
            self.errorLabel.text = ""
        }).disposed(by: disposeBag)
    }
    
    func bindResponse() {
        viewModel.loginResponse.subscribe(onNext: { [weak self] response in
            if let error = response.error {
                self?.errorLabel.text = error.description
            } else {
                self?.loginDone?()
            }
            self?.loginButton.isEnabled = true
        }).disposed(by: disposeBag)
    }
    
    func bindTextFieldToButton() {
        let loginFieldIsValidObservable = loginTextFeild.rx.text.map { $0 ?? "" }
        let passwordFieldIsValidObservable = passwordTextFeild.rx.text.map { $0 ?? "" }
        
        Observable
            .combineLatest(loginFieldIsValidObservable, passwordFieldIsValidObservable) { !$0.isEmpty && !$1.isEmpty }
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    func bindHUD() {
        viewModel.isLoading
            .subscribe(onNext: { [weak self] isLoading in
                isLoading ? self?.showProgress() : self?.hideProgress()
            })
            .disposed(by: disposeBag)
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        view.endEditing(false)
        loginButton.isEnabled = false
        viewModel.tryLogin(login: loginTextFeild.text!, password: passwordTextFeild.text!)
    }
    
}
