//
//  MapViewController.swift
//  CountriesAndStates
//
//  Created by Pamela Hernández on 31/10/23.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

final class MapViewController: MKMapView {
    
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
