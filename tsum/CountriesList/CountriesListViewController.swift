//
//  CountriesListViewController.swift
//  tsum
//
//  Created by Dmitriy Nazarychev on 10/12/2018.
//  Copyright © 2018 Nazarychev. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class CountriesListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: CountriesListViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBindings()
    }
    
    func setupViews() {
//        self.tableView.delegate = nil
//        self.tableView.dataSource = nil
    }
    
    func setupBindings() {
        let tableView: UITableView = self.tableView
        viewModel?.countries.drive(tableView.rx.items(cellIdentifier:"CountryCell", cellType: UITableViewCell.self)) { row, country, cell in
            cell.textLabel?.text = "\(country.name) \(country.population)"
        }.disposed(by: disposeBag)
    }

}
