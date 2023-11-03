//
//  ValuesGetEstadosbyPais.swift
//  CountriesAndStates
//
//  Created by Pamela Hernández on 02/11/23.
//

import XMLMapper

class ValuesGetEstadosbyPais: XMLMappable {
    
    var nodeName: String!
    
    var idEstado : Int?
    var estadoNombre: String?
    var coordenadas: String?
    var idPais: Int?
    
    required init?(map: XMLMap) {}
    
    func mapping(map: XMLMap) {
        idEstado <- map["idEstado"]
        estadoNombre <- map["EstadoNombre"]
        coordenadas <- map["Coordenadas"]
        idPais <- map["idPais"]
    }
}
