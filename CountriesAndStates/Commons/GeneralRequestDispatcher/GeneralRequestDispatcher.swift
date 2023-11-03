//
//  GeneralRequestDispatcher.swift
//  CountriesAndStates
//
//  Created by Pamela Hernández on 01/11/23.
//

import Foundation
import Alamofire
import XMLMapper

public typealias FetchSuccessful = (_ success : Bool, _ error : NSError?) -> ()

public class GeneralRequestDispatcher {
    static let shared = GeneralRequestDispatcher()
    
    public init(){}
    
    func fetchPOSTGetPaisesContent(completionHandler: @escaping (AFDataResponse<SoapEnvelopeResponse<GetPaisesResponse>>)-> ()) {
        let soapMessage = SoapMessage(methodName: "GetPaises", nameSpace: "http://tempuri.org/")
        let soapEnvelope = SoapEnvelope(soapMessage: soapMessage, envelopeParameter_1: "http://www.w3.org/2001/XMLSchema-instance", envelopeParameter_2: "http://www.w3.org/2001/XMLSchema", envelopeParameter_3: "http://schemas.xmlsoap.org/soap/envelope/")
        print("-----------Request Starts: GetPaises--------------")
        print("---------------------------------------------------")
        print(soapEnvelope.toXMLString() ?? "nil")
        print("---------------------------------------------------")
        print("---------------------------------------------------")
        print(soapEnvelope.toXML())
        print("---------------------------------------------------")
        print("-----------Request Ends: GetPaises--------------")
        AF.request("https://servicesoap.azurewebsites.net/ws/Paises.asmx", method: .post, parameters: soapEnvelope.toXML(), encoding: XMLEncoding.default).responseXMLObject { (response : AFDataResponse<SoapEnvelopeResponse<GetPaisesResponse>>) in
            completionHandler(response)
            guard let responseData = response.data else {
                print("Error en Soap: GetPaises: \(response.response?.statusCode ?? 0)")
                print("nil data received from SOAPResponse")
                return
            }
    
            let strData = String(data: responseData, encoding: .utf8)
            print("-----------Response Starts: GetPaises--------------")
            print("---------------------------------------------------")
            print("Body: \(strData ?? "")")
            print("---------------------------------------------------")
            print("-----------Response Ends: GetPaises--------------")
        }
    }
    
    func fetchPOSTGetEstadosbyPaisContent(idPais: Int, completionHandler: @escaping (AFDataResponse<SoapEnvelopeResponse<GetEstadosbyPaisResponse>>)-> ()) {
        let soapMessage = SoapMessage(soapParameter: idPais, methodName: "GetEstadosbyPais", nameSpace: "http://tempuri.org/")
        let soapEnvelope = SoapEnvelope(soapMessage: soapMessage, envelopeParameter_1: "http://www.w3.org/2001/XMLSchema-instance", envelopeParameter_2: "http://www.w3.org/2001/XMLSchema", envelopeParameter_3: "http://schemas.xmlsoap.org/soap/envelope/")
        print("-----------Request Starts: GetEstadosbyPais--------------")
        print("---------------------------------------------------")
        print(soapEnvelope.toXMLString() ?? "nil")
        print("---------------------------------------------------")
        print("---------------------------------------------------")
        print(soapEnvelope.toXML())
        print("---------------------------------------------------")
        print("-----------Request Ends: GetEstadosbyPais--------------")
        
        AF.request("https://servicesoap.azurewebsites.net/ws/Paises.asmx", method: .post, parameters: soapEnvelope.toXML(), encoding: XMLEncoding.default).responseXMLObject { (response : AFDataResponse<SoapEnvelopeResponse<GetEstadosbyPaisResponse>>) in
            completionHandler(response)
            guard let responseData = response.data else {
                print("Error en Soap: GetEstadosbyPais: \(response.response?.statusCode ?? 0)")
                print("nil data received from SOAPResponse")
                return
            }
    
            let strData = String(data: responseData, encoding: .utf8)
            print("-----------Response Starts: GetEstadosbyPais--------------")
            print("---------------------------------------------------")
            print("Body: \(strData ?? "")")
            print("---------------------------------------------------")
            print("-----------Response Ends: GetEstadosbyPais--------------")
        }
    }
}
