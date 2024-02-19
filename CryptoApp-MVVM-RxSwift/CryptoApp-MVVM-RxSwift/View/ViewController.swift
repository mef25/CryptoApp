//
//  ViewController.swift
//  CryptoApp-MVVM-RxSwift
//
//  Created by Mehmet Emin Fırıncı on 16.02.2024.
//

import UIKit
import RxSwift
import RxCocoa
class ViewController: UIViewController, UITableViewDelegate { //UITableViewDataSource
    @IBOutlet var tableView: UITableView!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    
    let cryptoVM = CryptoVieweModel()
    let disposeBag = DisposeBag()
    
    var cryptolist = [Crypto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.delegate = self
        //tableView.dataSource = self
        view.backgroundColor = UIColor.black
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        setupBindings()
        cryptoVM.requestData()
        
    }
    
    
    private func setupBindings(){
        
        cryptoVM
            .loading
            .bind(to: self.indicatorView.rx.isAnimating) // bind true gelirse animating başlicak false gelirse durucak
            .disposed(by: disposeBag)
        
        cryptoVM
            .error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { errorString in
            print(errorString)
            }
            .disposed(by: disposeBag)
        
        cryptoVM
            .cryptos
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: tableView.rx.items(cellIdentifier: "CryptoCell", cellType: CryptoTableViewCell.self)) { row,item,cell in
                cell.item = item
            }
            .disposed(by: disposeBag)
        
        /*cryptoVM
            .cryptos
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { cryptos in
            self.cryptolist = cryptos
            self.tableView.reloadData()
            }
            .disposed(by: disposeBag )
        */
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptolist.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = cryptolist[indexPath.row].currency
        content.secondaryText = cryptolist[indexPath.row].price
        cell.contentConfiguration = content
        return cell
    }
     */

}

