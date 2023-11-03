//
//  SoapEnvelope.swift
//  CountriesAndStates
//
//  Created by Pamela Hernández on 01/11/23.
//

import XMLMapper

class SoapEnvelope: XMLMappable {
    public var nodeName: String! = "soap:Envelope"
    
    var xsiSoap: String = "http://schemas.xmlsoap.org/soap/encoding/"
    var xsdSoap: String = "http://schemas.xmlsoap.org/soap/encoding/"
    var xmlnsSOAP: String = "http://schemas.xmlsoap.org/soap/envelope/"
    var soapBody: SOAPBody!
    var soapHeader: SOAPHeader?
    
    var nodesOrder: [String] = [
        "soap:Header",
        "soap:Body",
    ]
    
    public init(soapMessage: SoapMessage, soapInformation: SOAPInformation? = nil, envelopeParameter_1: String, envelopeParameter_2: String, envelopeParameter_3: String) {
        xsiSoap = envelopeParameter_1
        xsdSoap = envelopeParameter_2
        xmlnsSOAP = envelopeParameter_3
        self.soapBody = SOAPBody(soapMessage: soapMessage)
        if let soapInformation = soapInformation {
            self.soapHeader = SOAPHeader(soapInformation: soapInformation)
        }
    }
    
    required public init?(map: XMLMap) {}
    
    public func mapping(map: XMLMap) {
        xsiSoap <- map.attributes["xmlns:xsi"]
        xsdSoap <- map.attributes["xmlns:xsd"]
        xmlnsSOAP <- map.attributes["xmlns:soap"]
        soapHeader <- map["soap:Header"]
        soapBody <- map["soap:Body"]
        nodesOrder <- map.nodesOrder
    }
}
