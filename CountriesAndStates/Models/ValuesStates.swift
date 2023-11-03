//
//  ValuesStates.swift
//  CountriesAndStates
//
//  Created by Pamela Hernández on 02/11/23.
//

import Foundation

struct ValuesStates {
    var idEstado: Int?
    var stateName: String?
    var latitude: Double?
    var longitude: Double?
    var idPais: Int?
    
    init(_ idEstado: Int, _ stateName: String, _ latitude: Double, _ longitude: Double, _ idPais: Int) {
        self.idEstado = idEstado
        self.stateName = stateName
        self.latitude = latitude
        self.longitude = longitude
        self.idPais = idPais
    }
}

