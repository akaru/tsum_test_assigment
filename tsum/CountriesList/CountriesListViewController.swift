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
    private var refreshControl: UIRefreshControl!
    
    var viewModel: CountriesListViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBindings()
    }
    
    func setupViews() {
        self.title = "Countries"
        configureRefreshControl()
    }
    
    func setupBindings() {
        let tableView: UITableView = self.tableView
        viewModel?.countries.drive(tableView.rx.items(cellIdentifier:"CountryCell", cellType: SimpleCountryCell.self)) { row, country, cell in
            cell.viewModel = SimpleCountryCellViewModel(country: country)
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(SimpleCountry.self).asObservable().bind(to: viewModel.showCountry).disposed(by: disposeBag)
        
        viewModel.isRefreshing
            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    private func configureRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc private func refresh() {
        viewModel.refresh()
    }

}
