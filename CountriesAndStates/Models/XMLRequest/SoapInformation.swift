//
//  SoapInformation.swift
//  CountriesAndStates
//
//  Created by Pamela Hernández on 01/11/23.
//

import XMLMapper

class SOAPInformation: XMLMappable {
    public var nodeName: String!
    
    private var xmlnsInformation: String?
    var informationName: String?
    
    public init(informationName: String, nameSpace: String) {
        self.informationName = informationName
        self.xmlnsInformation = nameSpace
    }
    
    required public init?(map: XMLMap) {}
    
    open func mapping(map: XMLMap) {
        xmlnsInformation <- map.attributes["xmlns:"]
    }
}
