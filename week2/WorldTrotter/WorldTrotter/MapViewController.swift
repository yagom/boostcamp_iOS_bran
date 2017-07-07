//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by JU HO YOON on 2017. 7. 4..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit
import MapKit

class JHAnnotation: NSObject, MKAnnotation {

    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        
        super.init()
    }
    
    override init() {
        
        self.coordinate = CLLocationCoordinate2DMake(0, 0)
        self.title = nil
        self.subtitle = nil
        
        super.init()
    }
    
}

class MapViewController: UIViewController {
    
    var mapView: MKMapView!
    var completionBlock: (Bool) -> Void = { (com:Bool) -> Void in
        
    }
    var currentFunction: () -> Void = { () -> Void in
        print("Initial Print")
    }
    var locationManager: CLLocationManager!
    var bikeStations: [(String, Double, Double)] = []
    var zoomInButton: UIButton!
    var zoomOutButton: UIButton!
    var hasInteractiveAnnotation: Bool = false
    var interactiveAnnotation: JHAnnotation? = nil
    
    override func loadView() {
        // 지도 뷰 생성
        mapView = MKMapView()
        mapView.delegate = self
        
        // 지도 뷰를 이 뷰 컨르롤러의 view로 설정
        view = mapView
        
        // 세그먼트 추가.
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        segmentedControl.addTarget(self, action: #selector(self.mapTypeChanged(segControl:)), for: .valueChanged)
        
        let margins = view.layoutMarginsGuide
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        // 은메달 과제: 줌할 수 있는 버튼을 추가.
        self.zoomInButton = UIButton(type: .custom)
        self.zoomInButton.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        self.zoomInButton.setTitle("+", for: .normal)
        self.zoomInButton.setTitleColor(UIColor.blue, for: .normal)
        self.zoomInButton.addTarget(self, action: #selector(self.zoomButtonDidTouchUpInside(sender:)), for: .touchUpInside)
        self.zoomInButton.translatesAutoresizingMaskIntoConstraints = false
        zoomInButton.layer.cornerRadius = 25
        self.zoomInButton.tag = 0
        self.view.addSubview(self.zoomInButton)
        
        self.zoomOutButton = UIButton(type: .custom)
        self.zoomOutButton.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        self.zoomOutButton.setTitle("-", for: .normal)
        self.zoomOutButton.setTitleColor(UIColor.blue, for: .normal)
        self.zoomOutButton.addTarget(self, action: #selector(self.zoomButtonDidTouchUpInside(sender:)), for: .touchUpInside)
        self.zoomOutButton.translatesAutoresizingMaskIntoConstraints = false
        zoomOutButton.layer.cornerRadius = 25
        self.zoomOutButton.tag = 1
        self.view.addSubview(self.zoomOutButton)
        
        zoomOutButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 0).isActive = true
        zoomOutButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -8).isActive = true
        zoomOutButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        zoomOutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        zoomInButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 0).isActive = true
        zoomInButton.bottomAnchor.constraint(equalTo: zoomOutButton.topAnchor, constant: -8).isActive = true
        zoomInButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        zoomInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func mapTypeChanged(segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default :
            break
        }
    }
    
    func zoomButtonDidTouchUpInside(sender: UIButton) {
        let latitudeDelta = sender.tag == 0 ? self.mapView.region.span.latitudeDelta/2 : self.mapView.region.span.latitudeDelta*2
        let longitudeDelta = sender.tag == 0 ? self.mapView.region.span.longitudeDelta/2 : self.mapView.region.span.longitudeDelta*2
        
        let userLocation = self.mapView.userLocation.coordinate
        let radius = MKCoordinateSpan(latitudeDelta:  latitudeDelta, longitudeDelta: longitudeDelta)
        let region = MKCoordinateRegion(center: userLocation, span: radius)
        self.mapView.setRegion(region, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // CustomAnnotation
//        let hometownLocation = JHAnnotation()
//        hometownLocation.coordinate = CLLocationCoordinate2DMake(34.7714563, 127.07989440000006)
//        hometownLocation.title = "고향"
//        hometownLocation.subtitle = "전라남도 보성군"
//        mapView.addAnnotation(hometownLocation)
//        
//        // MKPointAnnotation.
//        let currentLocation = MKPointAnnotation()
//        currentLocation.coordinate = CLLocationCoordinate2D(latitude: 37.497072, longitude: 127.0285777000000)
//        currentLocation.title = "부스트 캠프"
//        currentLocation.subtitle = "강남역 3번 출구"
//        mapView.addAnnotation(currentLocation)
//        
//        let homeLocation = MKPointAnnotation()
//        homeLocation.coordinate = CLLocationCoordinate2D(latitude: 37.3112854, longitude: 126.81907550000005)
//        homeLocation.title = "우리집"
//        homeLocation.subtitle = "안산시 초지동"
//        mapView.addAnnotation(homeLocation)
        
        // Set Region
        let initialLocation = CLLocation(latitude: 37.497072, longitude: 127.0285777000000)
        let temp = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate, 4000, 4000)
        mapView.setRegion(temp, animated: true)
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        mapView.isRotateEnabled = true
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.mapViewDidLongPress(sender:)))
        mapView.addGestureRecognizer(longPressGestureRecognizer)
        
        // MKCircleView.
        let circleView = MKCircleView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        mapView.addSubview(circleView)
        
        //
        let circle = MKCircle(center: initialLocation.coordinate, radius: 1000)
        circle.title = "DOO Circle"
        mapView.addOverlays([circle])
        
        
        self.locationManager = CLLocationManager()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        
        mapView.setUserTrackingMode(.follow, animated: true)
        
        let url = URL(string: "http://openapi.seoul.go.kr:8088/5441567058796c6c36376c52437676/json/GeoInfoBikeConvenientFacilitiesWGS/1/800")
        let task = URLSession.shared.dataTask(with: url!) { (data, res, error) in
            if let jsonData = data {
                let json = try! JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                let bikes = json?["GeoInfoBikeConvenientFacilitiesWGS"] as? [String: Any]
                if let rows = bikes?["row"] as? [[String: Any]] {
                    for row in rows {
                        guard let latitude = row["LAT"] as? String,
                            let longitude = row["LNG"] as? String,
                            let address = row["ADDRESS"] as? String
                            else { return }
                        self.bikeStations.append((address, Double(latitude)!, Double(longitude)!))
                    }
                    self.updateStationPin()
                }
                
            }
            
        }
        task.resume()
    }
    
    func mapViewDidLongPress(sender: UILongPressGestureRecognizer) {
        switch sender.state {
        case .began:
            if !self.hasInteractiveAnnotation {
                let touchPoint = sender.location(in: self.mapView)
                let newCoordinate = self.mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
                let newAnnotation = JHAnnotation()
                newAnnotation.coordinate = newCoordinate
                let location = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
                CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
                    if let mark = placemarks?.first {
                        print(placemarks?.count)
                        newAnnotation.title = mark.name
                        newAnnotation.subtitle = "\(newCoordinate.latitude), \(newCoordinate.longitude)"
                    }
                })
                self.interactiveAnnotation = newAnnotation
                self.mapView.addAnnotation(newAnnotation)
            }
        case .ended:
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let fixAction = UIAlertAction(title: "Fix", style: .default, handler: { (action) in

            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                if let annotation = self.interactiveAnnotation {
                    self.mapView.removeAnnotation(annotation)
                }
            })
            alertController.addAction(fixAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        default:
            break
        }
    }
    
    func updateStationPin() {
        for station in self.bikeStations {
            let point = MKPointAnnotation()
            point.coordinate = CLLocationCoordinate2D(latitude: station.1, longitude: station.2)
            point.title = station.0
            point.subtitle = station.0
//            print("\(station.0), \(station.1), \(station.2)")
            self.mapView.addAnnotation(point)
        }
    }
}

extension MapViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    
    // MARK: MKMapViewDelegate - Zoom.
    
    // MARK: MKMapViewDelegate - Annotation.
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("didSelect")
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("callout")
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        print("state changed")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // MKPinAnnotationView
        if annotation.isKind(of: MKUserLocation.self) {
            let annotationView = MKAnnotationView()
            annotationView.image = #imageLiteral(resourceName: "car")
            return nil
        }
        
        if annotation.isKind(of: JHAnnotation.self) {
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "fixPin")
            pinView.canShowCallout = true
            pinView.animatesDrop = true
            pinView.leftCalloutAccessoryView = UIButton(type: .infoDark)
            pinView.pinTintColor = UIColor.red
            pinView.calloutOffset = CGPoint(x: -8, y: 5)
            return pinView
        }
        
        if let pinView = mapView.dequeueReusableAnnotationView(withIdentifier: "haveBeen") as? MKPinAnnotationView {
//            pinView.canShowCallout = true
//            pinView.animatesDrop = true
//            pinView.leftCalloutAccessoryView = UIButton(type: .infoDark)
//            pinView.pinTintColor = UIColor.green
//            pinView.calloutOffset = CGPoint(x: -8, y: 5)
            return pinView
        } else {
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "haveBeen")
            pinView.canShowCallout = true
            pinView.animatesDrop = true
            pinView.leftCalloutAccessoryView = UIButton(type: .infoDark)
            pinView.pinTintColor = UIColor.black
            pinView.calloutOffset = CGPoint(x: -8, y: 5)
            return pinView
        }
//        pinView.image = #imageLiteral(resourceName: "MapIcon")
//        pinView.isDraggable = true
    }
    
    // MARK: MKMapViewDelegate - Another.
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        print("didUpdateUserLocation")
        let userPoint = MKPointAnnotation()
        userPoint.coordinate = userLocation.coordinate
        self.mapView.addAnnotation(userPoint)
        
        if let location = userLocation.location?.coordinate {
            self.mapView.setCenter(location, animated: true)
        }
    }
    
    //MARK: CLLocationManagerDelegate.
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        manager.startUpdatingLocation()
//        manager.startUpdatingHeading()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocation")
        if let location = locations.first?.coordinate {
            self.mapView.setCenter(location, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        print("didUpdateHeading")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }

}
