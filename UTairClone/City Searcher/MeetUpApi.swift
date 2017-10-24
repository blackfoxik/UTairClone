//
//  MeetUpApi.swift
//  CitySearcher
//
//  Created by Anton on 22.10.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation


//Only for testing.
//This class need to be reimplemented with
//TaskPool which can allow us start/stop/check/close/ networking tasks
class MeetUPApi {
    static func getCities(with cityName: String, completion: @escaping (Any)->Void) {
        let url = URL(string: Keys.rootPath + Keys.queryPath + "\(cityName)")
        if url == nil {return}
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(error.debugDescription)")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response.debugDescription)")
                    return
                }
                completion(data)
            }
        }
        task.resume()
    }
}

struct Keys {
    static let rootPath: String = "https://api.meetup.com/2/cities/"
    static let queryPath: String = "?query="
}
