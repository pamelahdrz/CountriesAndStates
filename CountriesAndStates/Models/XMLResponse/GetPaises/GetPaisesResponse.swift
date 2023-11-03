//
//  SoapBodyResponse.swift
//  CountriesAndStates
//
//  Created by Pamela Hernández on 01/11/23.
//

import XMLMapper

class GetPaisesResponse: XMLMappable {
    
    var nodeName: String!
    
    var getPaisesResponse : TagsGetPaises?
    
    required init?(map: XMLMap) {}
    
    func mapping(map: XMLMap) {
        getPaisesResponse <- map["GetPaisesResponse.GetPaisesResult"]
    }
}
