//
//  MainViewController.swift
//  Payments
//
//  Created by Vigen Simonyan on 2/21/21.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    var viewModel: PaymentViewModelProtocol!
    private let disposeBag = DisposeBag()
    var logoutTapped: (() -> Void)?
    
    @IBOutlet weak var paymentsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paymentsTableView.register(UINib(nibName: "PaymentCell", bundle: nil), forCellReuseIdentifier: "Cell")
        bindHUD()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.items.bind(to: paymentsTableView.rx.items(cellIdentifier: "Cell", cellType: PaymentCell.self)) { (row, item, cell) in
            cell.amountLabel.text = (item.amount != nil) ? "\(item.amount!)" : "_"
            cell.createdLabel.text = (item.created != nil) ? "\(item.created!)" : "_"
            cell.currencyLabel.text = (item.currency != nil) ? "\(item.currency!)" : "_"
            cell.descLabel.text = (item.desc != nil) ? "\(item.desc!)" : "_"
        }.disposed(by: disposeBag)
        
        viewModel.fetchProductList()
    }
    
    func bindHUD() {
        viewModel.isLoading
            .subscribe(onNext: { [weak self] isLoading in
                isLoading ? self?.showProgress() : self?.hideProgress()
            })
            .disposed(by: disposeBag)
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        logoutTapped?()
    }
}

