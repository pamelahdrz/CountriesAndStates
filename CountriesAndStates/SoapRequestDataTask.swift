//
//  ViewController.swift
//  CountriesAndStates
//
//  Created by Pamela Hernández on 30/10/23.
//

import UIKit

///Example of Soap Request with
class SoapRequestDataTask: UIViewController {
    
    var is_SoapMessage = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetPaises xmlns=\"http://tempuri.org/\" /></soap:Body></soap:Envelope>"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.countriesExample()
    }
 
    func countriesExample() {
        guard let endpoint = URL(string:"https://servicesoap.azurewebsites.net/ws/Paises.asmx") else { return }
        var urlRequest = URLRequest(url: endpoint)
        
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = is_SoapMessage.data(using: .utf8)
        urlRequest.addValue("servicesoap.azurewebsites.net", forHTTPHeaderField: "Host")
        urlRequest.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(is_SoapMessage.count.stringValue, forHTTPHeaderField: "Content-Length")
        urlRequest.addValue("http://tempuri.org/GetPaises", forHTTPHeaderField: "SOAPAction")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            print("Response: \(response)")
            
            guard let responseData = data else {
                print("nil data received from SOAPResponse")
                return
            }
            
            let strData = String(data: responseData, encoding: .utf8)
            print("Body: \(strData)")
            
            if error != nil
            {
                print("Error: " + error.debugDescription)
            }
        }
        task.resume()
    }
}

