//
//  ViewController.swift
//  CitySearcher
//
//  Created by Anton on 21.10.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CitySearcherViewController: UIViewController {
    
    @IBOutlet weak var foundedCitiesTable: UITableView!
    @IBOutlet weak var searchingCityNameTextField: UITextField!
    
    var setSelectedCity: ((City?) -> Void)?
    
    private let disposeBag = DisposeBag()
    private let citySearcherViewModel = CitySearcherViewModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCityNameTextField()
        setupCitiesTable()
        setupCityChoiceFromCityTable()
        searchingCityNameTextField.becomeFirstResponder()
    }
    
}

extension CitySearcherViewController {
    private func setupCityNameTextField() {
        searchingCityNameTextField.rx.text
            .throttle(0.3, scheduler: MainScheduler.instance)
            .bind(to: citySearcherViewModel.searchText)
            .disposed(by: disposeBag)
    }
    
    private func setupCitiesTable() {
        citySearcherViewModel.cities.asObservable()
            .bind(to: foundedCitiesTable.rx.items(cellIdentifier: "CityCell")) { (row, element, cell) in
                cell.textLabel?.text = self.citySearcherViewModel.cities.value[row].name
                cell.detailTextLabel?.text = self.citySearcherViewModel.cities.value[row].country
            }
            .disposed(by: disposeBag)
    }
    
    private func setupCityChoiceFromCityTable() {
        foundedCitiesTable.rx.modelSelected(City.self)
            .subscribe(onNext: {city in
                self.setSelectedCity!(city)
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
}

