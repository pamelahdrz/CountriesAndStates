//
//  TagsResponse.swift
//  CountriesAndStates
//
//  Created by Pamela Hernández on 01/11/23.
//

import XMLMapper

class TagsGetPaises: XMLMappable {
    
    var nodeName: String!
    
    var tagsResponse : [ValuesGetPaises]?
    
    required init?(map: XMLMap) {}
    
    func mapping(map: XMLMap) {
        tagsResponse <- map["Paises.Pais"]
    }
}
