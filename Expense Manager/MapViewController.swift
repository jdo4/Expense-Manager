//
//  CustomCollectionViewCell.swift
//  Expense Manager
//
//  Created by Kamlesh on 2022-12-08.
//
import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    
    @IBOutlet weak var mv: MKMapView!
    let lm = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lm.requestAlwaysAuthorization()

            self.lm.requestWhenInUseAuthorization()
            if CLLocationManager.locationServicesEnabled() {
                lm.delegate = self
                lm.desiredAccuracy = kCLLocationAccuracyBest
                lm.startUpdatingLocation()
            }

            mv.delegate = self
            mv.mapType = .standard
            mv.isZoomEnabled = true
            mv.isScrollEnabled = true

            if let coor = mv.userLocation.location?.coordinate{
                mv.setCenter(coor, animated: true)
            }
    }
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate

        mv.mapType = MKMapType.standard

        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mv.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = locValue
        annotation.title = "Hello Prof. Igor"
        annotation.subtitle = "current location"
        mv.addAnnotation(annotation)

    }

    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        
        let id = MKMapViewDefaultAnnotationViewReuseIdentifier
        
        // Balloon Shape Pin (iOS 11 and above)
        if let view = mapView.dequeueReusableAnnotationView(withIdentifier: id) as? MKMarkerAnnotationView {
            if annotation.title == "Example 0" {
                view.titleVisibility = .visible
                view.subtitleVisibility = .visible
                view.markerTintColor = .yellow
                if #available(iOS 13.0, *) {
                    view.glyphImage = UIImage(systemName: "plus.viewfinder")
                } else {
                }
                view.glyphTintColor = .black
                return view
            }
        }
        
        if let view = mapView.dequeueReusableAnnotationView(withIdentifier: id) as? MKPinAnnotationView {
            if annotation.title == "Example 0" {
                view.animatesDrop = true
                view.pinTintColor = .yellow
                view.canShowCallout = true
                return view
            }
        }
        
        return nil
    }
    
}

