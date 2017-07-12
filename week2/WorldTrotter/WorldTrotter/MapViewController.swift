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

    /* 프로퍼티에 적절한 접근권한 줘보기 open, public, internal, fileprivate, private */
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
    
    // View Properties
    /* 프로퍼티에 적절한 접근권한 줘보기 open, public, internal, fileprivate, private */
    var mapView: MKMapView!
    var zoomInButton: UIButton!
    var zoomOutButton: UIButton!
    
    // Data.
    var bikeStations: [(String, Double, Double)] = [] {
        didSet {
            self.updateStationPin()
        }
    }
    
    // 이렇게 해보는 것은 어떨런지?
    private lazy var locationManager: CLLocationManager = {
        [unowned self] in
        
        let manager = CLLocationManager()
        manager.delegate = self
        
        return manager
    }()
    
    var hasInteractiveAnnotation: Bool = false
    var interactiveAnnotation: JHAnnotation? = nil
    
    var tourStationIndex = 0
    var tourTimer: Timer?
    
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
        
        // 버튼 추가.
        self.setupButtons()
    }
    
    func setupButtons(){
        let margins = view.layoutMarginsGuide
        // 금메달 과제: 핀 목록 순회.
        let buttonWidth:CGFloat = 50.0
        let buttonHeight:CGFloat = 50.0
        let currentButton = UIButton(type: .custom)
        currentButton.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        currentButton.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        currentButton.setTitle("◉", for: .normal)
        currentButton.setTitleColor(UIColor.blue, for: .normal)
        currentButton.addTarget(self, action: #selector(self.touchUpInsideCurrentButton(sender:)), for: .touchUpInside)
        currentButton.translatesAutoresizingMaskIntoConstraints = false
        currentButton.layer.cornerRadius = buttonWidth / 2
        self.view.addSubview(currentButton)
        
        let tourButton = UIButton(type: .custom)
        tourButton.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        tourButton.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        tourButton.setTitle("🚲", for: .normal)
        tourButton.setTitleColor(UIColor.blue, for: .normal)
        tourButton.addTarget(self, action: #selector(self.touchUpInsideTourButton(sender:)), for: .touchUpInside)
        tourButton.translatesAutoresizingMaskIntoConstraints = false
        tourButton.layer.cornerRadius = buttonWidth / 2
        self.view.addSubview(tourButton)
        
        currentButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 8).isActive = true
        currentButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -8).isActive = true
        currentButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        currentButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        
        tourButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 8).isActive = true
        tourButton.bottomAnchor.constraint(equalTo: currentButton.topAnchor, constant: -8).isActive = true
        tourButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        tourButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        
        // 은메달 과제: 줌할 수 있는 버튼을 추가.
        self.zoomInButton = UIButton(type: .custom)
        self.zoomInButton.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        self.zoomInButton.setTitle("+", for: .normal)
        self.zoomInButton.setTitleColor(UIColor.blue, for: .normal)
        self.zoomInButton.addTarget(self, action: #selector(self.touchUpInsideZoomButton(sender:)), for: .touchUpInside)
        self.zoomInButton.translatesAutoresizingMaskIntoConstraints = false
        zoomInButton.layer.cornerRadius = buttonWidth / 2
        self.zoomInButton.tag = 0
        self.view.addSubview(self.zoomInButton)
        
        self.zoomOutButton = UIButton(type: .custom)
        self.zoomOutButton.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        self.zoomOutButton.setTitle("-", for: .normal)
        self.zoomOutButton.setTitleColor(UIColor.blue, for: .normal)
        self.zoomOutButton.addTarget(self, action: #selector(self.touchUpInsideZoomButton(sender:)), for: .touchUpInside)
        self.zoomOutButton.translatesAutoresizingMaskIntoConstraints = false
        zoomOutButton.layer.cornerRadius = buttonWidth / 2
        self.zoomOutButton.tag = 1
        self.view.addSubview(self.zoomOutButton)
        
        zoomOutButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 0).isActive = true
        zoomOutButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -8).isActive = true
        zoomOutButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        zoomOutButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        
        zoomInButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 0).isActive = true
        zoomInButton.bottomAnchor.constraint(equalTo: zoomOutButton.topAnchor, constant: -8).isActive = true
        zoomInButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        zoomInButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
    }
    
    //MARK: Actions for SegmentControl
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
    
    //MARK: Actions for Button
    func touchUpInsideCurrentButton(sender: UIButton) {
        let currentRegion = MKCoordinateRegion(center: self.mapView.userLocation.coordinate, span: self.mapView.region.span)
        self.mapView.setRegion(currentRegion, animated: true)
    }
    
    func touchUpInsideTourButton(sender: UIButton) {
        guard !self.bikeStations.isEmpty else { return }
        
        // Tour nonAuto.
//        let nextTourStationIndex = self.tourStationIndex + 1
//        self.tourStationIndex = nextTourStationIndex < self.bikeStations.count ? nextTourStationIndex : 0
//        let station = self.bikeStations[self.tourStationIndex]
//        let stationCoordinate = CLLocationCoordinate2D(latitude: station.1, longitude: station.2)
//        self.mapView.setCenter(stationCoordinate, animated: true)
        
        // Tour Automatically.
        if self.tourTimer == nil {
            self.tourTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                let nextTourStationIndex = self.tourStationIndex + 1
                self.tourStationIndex = nextTourStationIndex < self.bikeStations.count ? nextTourStationIndex : 0
                let station = self.bikeStations[self.tourStationIndex]
                let anno = self.mapView.annotations.filter({ (annotation) -> Bool in
                    return (annotation.coordinate.latitude == station.1 && annotation.coordinate.longitude == station.2)
                })
                guard let annotation = anno.first else  { return }
                self.mapView.selectAnnotation(annotation, animated: true)
            }
        } else {
            self.tourTimer?.invalidate()
            self.tourTimer = nil
        }
        
    }
    
    func touchUpInsideZoomButton(sender: UIButton) {
        let latitudeDelta = sender.tag == 0 ? self.mapView.region.span.latitudeDelta/2 : self.mapView.region.span.latitudeDelta*2
        let longitudeDelta = sender.tag == 0 ? self.mapView.region.span.longitudeDelta/2 : self.mapView.region.span.longitudeDelta*2
        
//        let userLocation = self.mapView.userLocation.coordinate
        
        let radius = MKCoordinateSpan(latitudeDelta:  latitudeDelta, longitudeDelta: longitudeDelta)
        let region = MKCoordinateRegion(center: self.mapView.region.center, span: radius)
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
        
        // MapView.
        let initialLocation = CLLocation(latitude: 37.497072, longitude: 127.0285777000000)
        let region = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate, 4000, 4000)
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        mapView.isRotateEnabled = true
        mapView.setUserTrackingMode(.follow, animated: true)
        
        // Add LongPressGestureRecognizer To Add Pin.
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.mapViewDidLongPress(sender:)))
        mapView.addGestureRecognizer(longPressGestureRecognizer)
        
        // Lets make Circle Overlay.
        let circle = MKCircle(center: initialLocation.coordinate, radius: 2000)
        mapView.addOverlays([circle])
        
//        self.locationManager = CLLocationManager()
//        self.locationManager.delegate = self
        
        // CLLocation.
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            break
        case .denied:
            break
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        }
        
        APIManager.shared.getGeoInfoBikeConvenientFacilities { (stations) in
            self.bikeStations = stations.filter { !$0.0.isEmpty && $0.0 != " " }
                                        .sorted { $0.0 < $1.0 }
        }
    }
}

extension MapViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    
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
//            return nil
            let annotationView = MKAnnotationView()
            annotationView.image = "🕴🏻".image
            return annotationView
            
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
            let pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: "haveBeen")
            pinView.canShowCallout = true
            pinView.leftCalloutAccessoryView = UIButton(type: .infoDark)
            pinView.calloutOffset = CGPoint(x: -8, y: 5)
            pinView.isDraggable = true
            pinView.image = "🚲".image
            // MKPinAnnotationView Properties.
//            pinView.pinTintColor = UIColor.black
//            pinView.animatesDrop = true
            return pinView
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay.isKind(of: MKCircle.self) {
            let circleRenderer = MKCircleRenderer(overlay: overlay)
            circleRenderer.fillColor = UIColor.blue.withAlphaComponent(0.1)
            circleRenderer.strokeColor = UIColor.blue
            circleRenderer.lineWidth = 1
            return circleRenderer
        }
        return MKOverlayRenderer()
        
    }
    
    // MARK: MKMapViewDelegate - ETC.
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        print("didUpdateUserLocation")
//        let userPoint = MKPointAnnotation()
//        userPoint.coordinate = userLocation.coordinate
//        self.mapView.addAnnotation(userPoint)
        
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

extension MapViewController {
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
