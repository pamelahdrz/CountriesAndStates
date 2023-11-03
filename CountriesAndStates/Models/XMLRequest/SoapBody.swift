//
//  SoapBody.swift
//  CountriesAndStates
//
//  Created by Pamela Hernández on 01/11/23.
//

import XMLMapper

public class SOAPBody: XMLMappable {
    public var nodeName: String! 
    
    var soapMessage: SoapMessage?
    
    private var soapAction: String?
    private var methodName: String?
    
    init(soapMessage: SoapMessage) {
        self.soapAction = soapMessage.xmlnsMessage
        self.methodName = soapMessage.methodName
        self.soapMessage = soapMessage
    }
    
    required public init?(map: XMLMap) {}
    
    public func mapping(map: XMLMap) {
        soapMessage <- map[(methodName ?? "")]
    }
}

