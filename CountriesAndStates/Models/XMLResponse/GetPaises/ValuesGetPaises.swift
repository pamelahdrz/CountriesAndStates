//
//  ValuesResponse.swift
//  CountriesAndStates
//
//  Created by Pamela Hernández on 01/11/23.
//

import XMLMapper

class ValuesGetPaises: XMLMappable {
    
    var nodeName: String!
    
    var idPais : Int?
    var nombrePais: String?
    
    required init?(map: XMLMap) {}
    
    func mapping(map: XMLMap) {
        idPais <- map["idPais"]
        nombrePais <- map["NombrePais"]
    }
}
