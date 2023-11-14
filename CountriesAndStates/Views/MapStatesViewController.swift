//
//  MapStatesViewController.swift
//  CountriesAndStates
//
//  Created by Pamela Hernández on 02/11/23.
//

import Foundation
import UIKit
import MapKit

///Region to show in MapView
private enum RegionCoordinates {
    static let mexico: (latitude: Double, longitude: Double) = (24.4535256, -102.9779177)
    static let usa: (latitude: Double, longitude: Double) = (40.2116194, -117.8427562)
}

class MapStatesViewController: UIViewController, UIGestureRecognizerDelegate, MapStatesControllerDelegate {
    
    var idPais: Int?
    var country: String?
    
    ///Coordinates for Region
    private var latitude: Double?
    private var longitude: Double?
    
    @IBOutlet private weak var mapView: MKMapView!
    
    private var viewModel = MapStatesViewModel()
    private let locationManager = CLLocationManager()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func statesParameter(idPais: Int, country: String) {
        self.idPais = idPais
        self.country = country
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.configureMapView()
        self.initMapView()
    }
    
    private func setupView() {
        self.viewModel.viewController = self
        self.configureNavigationBar()
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
        ///CLLocationManagerDelegate Configuration
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
        self.locationManager.requestLocation()
        ///MKMapViewDelegate Configuration
        self.mapView.delegate = self
    }
    
    private func initMapView() {
        self.viewModel.fetchStates(idPais: idPais ?? 0) { success, error in
            if success {
                DispatchQueue.main.async {
                    self.displayMultipleAnnotations()
                    self.setSpecificRegion()
                }
            }
        }
    }
    
    private func displayMultipleAnnotations() {
        self.viewModel.customAnnotationA.forEach { annotation in
            mapView.addAnnotation(annotation)
        }
    }
    
    private func setSpecificRegion() {
        let country = Country(rawValue: self.country ?? "")
        
        switch country {
        case .Mexico:
            latitude = RegionCoordinates.mexico.latitude
            longitude = RegionCoordinates.mexico.longitude
        case .USA:
            latitude = RegionCoordinates.usa.latitude
            longitude = RegionCoordinates.usa.longitude
        case .none:
            break
        }
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude ?? 0.0, longitude: longitude ?? 0.0), span: MKCoordinateSpan(latitudeDelta: 30, longitudeDelta: 30))
        mapView.setRegion(region, animated: true)
    }
    
    @objc private func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension MapStatesViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        ///CLLocationManagerDelegate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        ///CLLocationManagerDelegate
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is CustomAnnotation else {return nil}
        
        let identifier = "CustomAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        pin.pinTintColor = .red
        annotationView = pin
        
        ///Add Callout To Annotation View
        //annotationView?.canShowCallout = true
        
        //let buttonAnnotation = UIButton(type: .detailDisclosure)
        //annotationView?.rightCalloutAccessoryView = buttonAnnotation
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let selectedAnnotation = view.annotation as? CustomAnnotation else { return }
        
        if let stateName = selectedAnnotation.stateName, let country = self.country {
            self.viewModel.configureAlertView(with: stateName, selectedAnnotation.coordinate.latitude, selectedAnnotation.coordinate.longitude, country)
        }
    }
}

