//
//  SoapEnvelopeResponse.swift
//  CountriesAndStates
//
//  Created by Pamela Hernández on 01/11/23.
//

import XMLMapper

class SoapEnvelopeResponse <T: XMLMappable> : XMLMappable{
    
    var nodeName: String!

    var body : T?

    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        body <- map["soap:Body"]
    }
    
}
