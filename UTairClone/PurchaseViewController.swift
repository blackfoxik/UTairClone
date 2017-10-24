//
//  PurchaseViewController.swift
//  UTairClone
//
//  Created by Anton on 24.10.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import UIKit

class PurchaseViewController: UIViewController {
    
    var flightOrder: FlightOrder?
    
    @IBOutlet weak var fromToCitiesContainerView: UIView!
 
}

extension PurchaseViewController {
    private func restoreFlightOrder() {
        //we can store statement of flightOrder between launches app and restore it
        flightOrder = FlightOrder()
    }
    //durty method, need to replace with initiator and inject flightOrder with init
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        restoreFlightOrder()
        if let fromToCities = segue.destination as? FromToCitiesViewController {
            fromToCities.flightOrder = flightOrder
        }
    }
}
