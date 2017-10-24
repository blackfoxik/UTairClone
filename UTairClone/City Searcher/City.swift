//
//  City.swift
//  CitySearcher
//
//  Created by Anton on 21.10.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation
import SwiftyJSON

class City {
    var name: String?
    var country: String?
    
    init (json: JSON) {
        self.name = json["city"].stringValue
        self.country = json["country"].stringValue
    }
    public init() {}
}

extension City: Equatable {
    static func ==(lhs: City, rhs: City) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}
