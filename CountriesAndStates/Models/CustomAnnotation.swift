//
//  CustomAnnotation.swift
//  CountriesAndStates
//
//  Created by Pamela Hernández on 03/11/23.
//

import MapKit

class CustomAnnotation: NSObject, MKAnnotation {

    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?

    init(coordinate:CLLocationCoordinate2D, title: String?, subtitle:
    String?){
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
