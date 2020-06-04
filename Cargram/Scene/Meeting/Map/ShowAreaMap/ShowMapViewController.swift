//
//  ShowMapViewController.swift
//  Cargram
//
//  Created by Ferhan Akkan on 4.06.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class ShowMapViewController: UIViewController {
    
    var mapView = GMSMapView()
    let locationManager = CLLocationManager()
    var customView: [PickerCardViewController] = []
    let mapViewModel = ShowMapViewModel()
    var delegate: SelectedArea? = nil
    var id = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocation()
        setMapView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var counter = 0
        if mapViewModel.eventArray.count > 0 {
            for event in mapViewModel.eventArray {
                let cll2d = CLLocationCoordinate2D(latitude: event.latitude, longitude: event.longitude)
                createPickerCard(coordinate: cll2d, id: counter)
                counter += 1
            }
        }
    }
}

//MARK: - SetUI

extension ShowMapViewController {
    
    private func setMapView() {
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.indoorPicker = true
        mapView.settings.rotateGestures = true
        mapView.settings.zoomGestures = true
        mapView.delegate = self
    }
        
}

//MARK: - Actions

extension ShowMapViewController {

    
    private func createPickerCardViewAnimation(id: Int) {
        self.view.addSubview(customView[id])
        customView[id].setView()
        
        self.customView[id].snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(50)
            make.height.equalTo(UIScreen.main.bounds.height*0.3)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
            self.customView[id].snp.makeConstraints { (make) in
                make.leading.trailing.equalToSuperview()
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
                make.height.equalTo(UIScreen.main.bounds.height*0.3)
            }
            
            UIView.animate(withDuration: 1, animations: {
                self.view.layoutIfNeeded()
            }, completion: { _ in
                 self.mapViewModel.doesPickerCardOnScreen = true
            })
        }
    }
    
    private func deletePickerCardViewAnimation(id: Int) {
            self.customView[id].snp.makeConstraints { (make) in
                make.leading.trailing.equalToSuperview()
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
                make.height.equalTo(UIScreen.main.bounds.height*0.3)
            }
            
            UIView.animate(withDuration: 1, animations: {
                self.view.layoutIfNeeded()
            }, completion: { [unowned self]_ in
                self.customView[id].removeFromSuperview()
                self.mapViewModel.doesPickerCardOnScreen = false
            })
    }
    

    
    private func createMarker(coordinate: CLLocationCoordinate2D, id: Int) {
        let marker = GMSMarker(position: coordinate)
        marker.id = id
        let markerImage = UIImage(named: "marker")!
        let image = UIImageView(image: markerImage)
        image.frame.size = CGSize(width: 40, height: 40)
        marker.iconView = image
        marker.map = mapView
    }
    
    private func createPickerCard(coordinate: CLLocationCoordinate2D, id: Int) {
        createMarker(coordinate: coordinate, id: id)
        let view = PickerCardViewController()
        customView.append(view)
        customView[id].type = .showArea
        self.view.addSubview(customView[id])
        customView[id].setView()
        customView[id].latitude = coordinate.latitude
        customView[id].longitude = coordinate.longitude
        customView[id].title.text = "Destination"
         mapViewModel.getLocationAddress(coordinate: coordinate, completion: { [unowned self](address) in
            self.customView[id].subtitle.text = address
        })
    }
    
}


//MARK: - Core Locations

extension ShowMapViewController: CLLocationManagerDelegate {
    
    private func setLocation() {
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        let camera = GMSCameraPosition.camera(withLatitude: locValue.latitude, longitude: locValue.longitude, zoom: 15.0)
            mapView.camera = camera
        locationManager.stopUpdatingLocation()
    }
    
}

//MARK: - Google Map

extension ShowMapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if !mapViewModel.doesPickerCardOnScreen {
            id = marker.id
            createPickerCardViewAnimation(id:id)
        }
        return true
    }
        
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        deletePickerCardViewAnimation(id: id)
    }
    
}

