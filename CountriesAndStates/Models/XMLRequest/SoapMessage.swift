//
//  SoapMessage.swift
//  CountriesAndStates
//
//  Created by Pamela Hernández on 01/11/23.
//

import XMLMapper

class SoapMessage: XMLMappable {
    public var nodeName: String!
    
    var methodName: String?
    var xmlnsMessage: String?
    var soapParameter: Int?
    
    public init(soapParameter: Int = 0, methodName: String, nameSpace: String) {
        self.methodName = methodName
        self.xmlnsMessage = nameSpace
        self.soapParameter = soapParameter
    }
    
    required public init?(map: XMLMap) {}
    
    open func mapping(map: XMLMap) {
        xmlnsMessage <- map.attributes["xmlns"]
        
        ///Parameter usage for: SoapRequest: GetEstadosbyPais
        soapParameter <- map["idEstado"]
    }
}
