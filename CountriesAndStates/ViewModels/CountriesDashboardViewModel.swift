//
//  CountriesDashboardViewModel.swift
//  CountriesAndStates
//
//  Created by Pamela Hernández on 02/11/23.
//

import Foundation
import UIKit

enum Country: String, CaseIterable {
    case Mexico = "Mexico"
    case USA = "USA"
}

enum CountriesCellModel {
    case countries(_ items: [ValuesGetPaises])
}

final class CountriesDashboardViewModel {
    
    var valuesResponse = [CountriesCellModel]()
    
    var numberOfCountries: Int {
        return valuesResponse.count
    }
    
    func fetchCountries(completionHandler:@escaping FetchSuccessful) {
        GeneralRequestDispatcher.shared.fetchPOSTGetPaisesContent { (response) in
            switch response.result {
            case .success(let data):
                if let dataCountries = data.body?.getPaisesResponse?.tagsResponse {
                    self.valuesResponse.append(.countries(dataCountries))
                }
                completionHandler(true, nil)
            case .failure(let error):
                completionHandler(true, error as NSError)
                print("Error en SoapRequest: \(response.response?.statusCode ?? 0)")
            }
        }
    }
}
