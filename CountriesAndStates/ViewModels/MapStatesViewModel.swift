//
//  MapStatesViewModel.swift
//  CountriesAndStates
//
//  Created by Pamela Hernández on 02/11/23.
//

import Foundation
import UIKit
import MapKit

protocol MapStatesControllerDelegate: AnyObject {
    func statesParameter(idPais: Int, country: String)
}

final class MapStatesViewModel {
    
    weak var viewController: UIViewController?
    
    var valuesStates = [ValuesStates]()
    var customAnnotationA = [CustomAnnotation]()
    
    func fetchStates(idPais: Int, completionHandler: @escaping FetchSuccessful) {
        GeneralRequestDispatcher.shared.fetchPOSTGetEstadosbyPaisContent(idPais: idPais) { (response) in
            switch response.result {
            case .success(let data):
                if let dataStates = data.body?.getEstadosbyPaisResponse?.tagsResponse {
                    dataStates.forEach { statesInfo in
                        if let idEstado = statesInfo.idEstado, let estadoNombre = statesInfo.estadoNombre, let coordenadas = statesInfo.coordenadas, let idPais = statesInfo.idPais {
                            let coordinates : [String] = coordenadas.components(separatedBy: ",")
                            let latitude : String = coordinates[0]
                            let longitude : String = coordinates[1]
                            
                            ///ValuesStates Array
                            let values = ValuesStates(idEstado, estadoNombre, latitude.toDouble() ?? 0.0, longitude.toDouble() ?? 0.0, idPais)
                            self.valuesStates.append(values)
                            
                            ///CustomAnnotation Array
                            let customAnnotation = CustomAnnotation(coordinate:  CLLocationCoordinate2D(latitude: latitude.toDouble() ?? 0.0, longitude: longitude.toDouble() ?? 0.0), stateName: estadoNombre)
                            self.customAnnotationA.append(customAnnotation)
                        }
                    }
                }
                completionHandler(true, nil)
                
            case .failure(let error):
                completionHandler(true, error as NSError)
                print("Error en SoapRequest: \(response.response?.statusCode ?? 0)")
            }
        }
    }
    
    func configureAlertView(with stateName: String, latitude: Double, longitude: Double, country: String) {
        let message = """
                       Country: \(country)
                       Latitude: \(latitude)
                       Longitude: \(longitude)
                       """
        
        let alert = UIAlertController(title: stateName, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(OKAction)
        
        self.viewController?.navigationController?.present(alert, animated: true, completion: nil)
    }
}
