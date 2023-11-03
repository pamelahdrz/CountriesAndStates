//
//  TagsGetEstadosbyPais.swift
//  CountriesAndStates
//
//  Created by Pamela Hernández on 02/11/23.
//

import XMLMapper

class TagsGetEstadosbyPais: XMLMappable {
    
    var nodeName: String!
    
    var tagsResponse : [ValuesGetEstadosbyPais]?
    
    required init?(map: XMLMap) {}
    
    func mapping(map: XMLMap) {
        tagsResponse <- map["Estados.Estado"]
    }
}
