//
//  PaymentViewModel.swift
//  Payments
//
//  Created by Vigen Simonyan on 2/22/21.
//

import Foundation
import Moya
import RxSwift

protocol PaymentViewModelProtocol {
    var isLoading: BehaviorSubject<Bool> { get }
    var items: PublishSubject<[Payment]> { get }
    func fetchProductList()
}

class PaymentViewModel: PaymentViewModelProtocol {
    let isLoading = BehaviorSubject<Bool>(value: false)

    let items = PublishSubject<[Payment]>()
    
    func fetchProductList() {
        self.isLoading.onNext(true)
        let provider = MoyaProvider<PaymentsAPI>()
        provider.request(.payments) { [weak self] response in
            self?.isLoading.onNext(false)
            guard let self = self else { return }
            switch response {
            case .success(let result):
                do {
                    let paymentResponse = try JSONDecoder().decode(PaymentsResponse.self, from: result.data)
                    if let error = paymentResponse.error {
                        print(error)
                    } else {
                        self.items.onNext(paymentResponse.paymentsResult!)
                        self.items.onCompleted()
                    }
                } catch {
                    print(error)
                }
            case .failure(let error):
                print("error - \(error)")
            }
        }
    }
}
