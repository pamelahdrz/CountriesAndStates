//
//  GetEstadosbyPaisResponse.swift
//  CountriesAndStates
//
//  Created by Pamela Hernández on 02/11/23.
//

import XMLMapper

class GetEstadosbyPaisResponse: XMLMappable {
    
    var nodeName: String!
    
    var getEstadosbyPaisResponse : TagsGetEstadosbyPais?
    
    required init?(map: XMLMap) {}
    
    func mapping(map: XMLMap) {
        getEstadosbyPaisResponse <- map["GetEstadosbyPaisResponse.GetEstadosbyPaisResult"]
    }
}
