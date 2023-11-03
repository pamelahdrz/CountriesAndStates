//
//  CustomAnnotation.swift
//  CountriesAndStates
//
//  Created by Pamela Hernández on 03/11/23.
//

import MapKit

class CustomAnnotation: NSObject, MKAnnotation {

    var coordinate: CLLocationCoordinate2D
    var stateName: String?

    init(coordinate:CLLocationCoordinate2D, stateName: String) {
        self.coordinate = coordinate
        self.stateName = stateName
    }
}
