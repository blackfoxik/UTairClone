//
//  ViewModel.swift
//  CitySearcher
//
//  Created by Anton on 22.10.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

class CitySearcherViewModel {
    let disposeBag = DisposeBag()
    var cities = Variable<[City]>([])
    var searchText = Variable<String?>("")
    
    
    init() {
        setupSearchTextChanging()
    }
    
    private func setupSearchTextChanging() {
        searchText.asObservable()
            .subscribe({_ in
                self.getCities()
            })
            .disposed(by: disposeBag)
    }
    
    private func getCities() {
        cities.value.removeAll()
        if searchText.value == nil || searchText.value == "" {return}
        MeetUPApi.getCities(with: "\(searchText.value ?? "" )") { result in
            let jCities = JSON(result)
            for curJCity in jCities["results"] {
                let city = City(json: curJCity.1)
                self.cities.value.append(city)
            }
        }
    }
}
