//
//  MapStatesViewController.swift
//  CountriesAndStates
//
//  Created by Pamela Hernández on 02/11/23.
//

import Foundation
import UIKit
import MapKit

class MapStatesViewController: UIViewController, UIGestureRecognizerDelegate, MapStatesControllerDelegate {
    
    var idPais: Int?
    
    @IBOutlet weak var mapView: MKMapView!
    
    private var viewModel = MapStatesViewModel()
    let locationManager = CLLocationManager()
    
    func statesParameter(idPais: Int) {
        self.idPais = idPais
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar()
        self.configureMapView()
        self.initMapView()
    }
    
    @available(iOS 15.0, *)
    private func configureNavigationBar() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationItem.setLeftBarButton(
            .createBarButtonItem(
                image: UIGeneral.backButton,
                target: self,
                action: #selector(self.backAction)),
            animated: true)
    }
    
    private func configureMapView() {
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
        self.locationManager.requestLocation()
    }
    
    private func initMapView() {
        self.viewModel.fetchStates(idPais: idPais ?? 0) { success, error in
            if success {
                DispatchQueue.main.async {
                    self.displayMultipleAnnotations()
                }
            }
        }
    }
    
    private func displayMultipleAnnotations() {
        self.viewModel.customAnnotationA.forEach { annotation in
            mapView.addAnnotation(annotation)
        }
    }
    
    @objc private func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension MapStatesViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        ///
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        ///
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is CustomAnnotation else {return nil}
        
        let identifier = "CustomAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        //annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        annotationView?.canShowCallout = true
        
        //let buttonAnnotation = UIButton(type: .detailDisclosure)
        //annotationView?.rightCalloutAccessoryView = buttonAnnotation
        return annotationView
    }
}

