//
//  FromToCitiesViewController.swift
//  UTairClone
//
//  Created by Anton on 24.10.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import UIKit

class FromToCitiesViewController: UIViewController {
    @IBOutlet weak var fromCityButton: UIButton!
    @IBOutlet weak var toCityButton: UIButton!
    var flightOrder: FlightOrder?
  
    @IBAction func fromCitySelecting(_ sender: UIButton) {
        flightOrder?.fromCity = selectCity()
    }
    @IBAction func toCitySelecting(_ sender: UIButton) {
        flightOrder?.toCity = selectCity()
    }
    
    private func selectCity() -> City? {
        let citySearcherViewController = CitySearcherViewController.instantiateFromAppStoryboard(appStoryboard: .Purchase)
        let city: City? = City()
        citySearcherViewController?.setSelectedCity = { selectedCity in
            
            DispatchQueue.main.async {
                if city == self.flightOrder?.fromCity {
                    self.flightOrder?.fromCity = selectedCity
                    self.fromCityButton.setTitle(selectedCity?.name, for: .normal)
                } else {
                    self.flightOrder?.toCity = selectedCity
                    self.toCityButton.setTitle(selectedCity?.name, for: .normal)
                }
            }
        }
       
        present(citySearcherViewController!, animated: true)
        return city
    }
}
