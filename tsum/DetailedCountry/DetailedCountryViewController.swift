//
//  DetailedCountryViewController.swift
//  tsum
//
//  Created by Dmitriy Nazarychev on 10/12/2018.
//  Copyright © 2018 Nazarychev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailedCountryViewController: UIViewController {
    
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var borederedCountriesLabel: UILabel!
    @IBOutlet weak var currenciesLabel: UILabel!
    
    @IBOutlet weak var loadingIndicatorView: UIView!
    
    var viewModel: DetailedCountryViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Country details"
        setupBindings()
        // Do any additional setup after loading the view.
    }
    
    func setupBindings() {
        viewModel.countryNameDriver.drive(countryNameLabel.rx.text).disposed(by: disposeBag)
        viewModel.capitalDriver.drive(capitalLabel.rx.text).disposed(by: disposeBag)
        viewModel.populationDriver.drive(populationLabel.rx.text).disposed(by: disposeBag)
        viewModel.borederedCountriesDriver.drive(borederedCountriesLabel.rx.text).disposed(by: disposeBag)
        viewModel.currenciesDriver.drive(currenciesLabel.rx.text).disposed(by: disposeBag)
        viewModel.isRefreshing.map{!$0}.bind(to: loadingIndicatorView.rx.isHidden).disposed(by: disposeBag)
    }

}
