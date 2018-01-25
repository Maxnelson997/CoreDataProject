//
//  service.swift
//  coredatacourse
//
//  Created by Max Nelson on 1/25/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import Foundation

struct Service {
    
    static let shared = Service()
    
    let urlString = "http://api.letsbuildthatapp.com/intermediate_training/companies"
    
    func downloadCompaniesFromServer() {
        print("Attempting to download companies from server....")
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            if let err = err {
                print("error fetching companies from server:",err)
                return
            }
            print("finished downloading")
            guard let data = data else { return }
            let jsonDecoder = JSONDecoder()
            do {
                let jsonCompanies = try jsonDecoder.decode([JSONCompany].self, from: data)
                
                jsonCompanies.forEach({ (jsonCompany) in
                    print(jsonCompany.name)
                    print(jsonCompany.founded)
                    jsonCompany.employees?.forEach({ (jsonEmployee) in
                        print(" - " + jsonEmployee.name)
                    })
                    
                })
            } catch let err {
                print("error decoding json data to json company:",err)
            }
            
        }.resume()
    }
    
}

struct JSONCompany: Decodable {
    let name: String
    let founded: String
    var employees: [JSONEmployee]?
}

struct JSONEmployee: Decodable {
    let name: String
    let birthday: String
    let type: String
}
