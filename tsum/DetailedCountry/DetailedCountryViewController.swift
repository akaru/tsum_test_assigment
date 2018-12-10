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
    
    
    
    var viewModel: DetailedCountryViewModel!
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        // Do any additional setup after loading the view.
    }
    
    func setupBindings() {

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
