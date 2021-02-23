//
//  LoginViewModel.swift
//  Payments
//
//  Created by Vigen Simonyan on 2/22/21.
//

import Foundation
import RxSwift
import Moya

protocol LoginViewModelProtocol {
    var isLoading: BehaviorSubject<Bool> { get }
    var loginResponse: PublishSubject<LoginResponse> { get }
    func tryLogin(login: String, password: String)
}

class LoginViewModel: LoginViewModelProtocol {
    let isLoading = BehaviorSubject<Bool>(value: false)

    let loginResponse = PublishSubject<LoginResponse>()
    
    func tryLogin(login: String, password: String) {
        self.isLoading.onNext(true)
        let provider = MoyaProvider<PaymentsAPI>()
        provider.request(.login(login: login, password: password)) { [weak self] response in
            self?.isLoading.onNext(false)
            switch response {
            case .success(let result):
                do {
                    let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: result.data)
                    PaymentsAPI.token = loginResponse.loginResult?.token
                    self?.loginResponse.onNext(loginResponse)
                } catch {
                    print("login failure - \(error)")
                }
            case .failure(let error):
                print("login failure - \(error)")
            }
        }
    }
}
