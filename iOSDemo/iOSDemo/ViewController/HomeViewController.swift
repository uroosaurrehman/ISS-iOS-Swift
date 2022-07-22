    //
    //  HomeViewController.swift
    //  iOSDemo
    //
    //  Created by Uroosa on 07/22/22.
    //

import UIKit
import MapKit

class HomeViewController: UIViewController {

        // MARK: - OUTLET
    @IBOutlet weak var lblPosition: UILabel!
    @IBOutlet weak var mapView: MKMapView?
    private var interval = 3.0

        // MARK: - PROPERTY
    private var pointAnnotation: MKPointAnnotation?
    private var positionViewModel: ISSPositionViewModel?
    private var issLocation: CLLocation?
    @objc dynamic var coordinate: CLLocationCoordinate2D {
        if let lat = issLocation?.coordinate.latitude,
           let lon = issLocation?.coordinate.longitude {
            let currentLocation = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            return currentLocation
        }
            // Else, set the user's location
        let currentLocation = CLLocationCoordinate2D(latitude: 19.01999992, longitude: -98.62333084)
        return currentLocation
    }
        // MARK: - LIFE CYCLE
    override func viewDidLoad() {

        super.viewDidLoad()

        setupMap()

    }
        // MARK: - UI SETUP
    override func viewDidAppear(_ animated: Bool) {
        initViewModels()
        setupTimer()
    }

        // MARK: - BUTTON CLICK

        // MARK: - OTHER
    func setupMap() {
        mapView?.delegate = self
        pointAnnotation = MKPointAnnotation()
        pointAnnotation?.title = "ISS"
    }

    func initViewModels() {
        positionViewModel = ISSPositionViewModel()
        positionViewModel?.delegate = self
    }

    func setupTimer() {
        Timer.scheduledTimer(withTimeInterval: interval,
                             repeats: true) { timer in
            self.positionViewModel?.makeRequest()
            self.updateLocation()
        }
    }

    func updateLocation() {
        guard let location = issLocation else { return }
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: 10000000,
                                                  longitudinalMeters: 10000000)

        guard let point = pointAnnotation else { return }
        point.coordinate = coordinate

        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            self.mapView?.addAnnotation(point)
            self.mapView?.setRegion(coordinateRegion, animated: true)
            self.lblPosition.text = "The ISS is currently over\n\(coordinateRegion.center.latitude)° N, \(coordinateRegion.center.longitude)° E"
        })
    }
}

extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "issMarker")
        annotationView.markerTintColor = UIColor(red: (69.0/255), green: (95.0/255), blue: (170.0/255), alpha: 1.0)
        annotationView.glyphImage = UIImage(named: "satellite")
        return annotationView
    }
}

extension HomeViewController: ISSPositionDelegate {
    func getPosition(latitude: Double, longitude: Double) {
        issLocation = CLLocation(latitude: latitude, longitude: longitude)
        updateLocation()
    }
}
