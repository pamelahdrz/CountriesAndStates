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
    
    weak var viewController: UIViewController?
    
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
    
    func performSegue(with data: ValuesGetPaises) {
        let destination = MapStatesViewController()
        destination.modalPresentationStyle = .fullScreen
        
        if let idPais = data.idPais, let country = data.nombrePais {
            destination.idPais = idPais
            destination.country = country
        }
        
        self.viewController?.navigationController?.pushViewController(destination, animated: true)
    }
}
