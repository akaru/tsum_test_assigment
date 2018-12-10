//
//  SimpleCountryCell.swift
//  tsum
//
//  Created by Dmitriy Nazarychev on 10/12/2018.
//  Copyright © 2018 Nazarychev. All rights reserved.
//

import UIKit
import RxSwift

class SimpleCountryCell: UITableViewCell {

    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryPopulationLabel: UILabel!
    
    var disposeBag = DisposeBag()
    
    var viewModel: SimpleCountryCellViewModel! {
        didSet {
            setupBindings()
        }
    }
    
    func setupBindings() {
        viewModel.countryName.drive(countryNameLabel.rx.text).disposed(by: disposeBag)
        viewModel.countryPopulation.drive(countryPopulationLabel.rx.text).disposed(by: disposeBag)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

}