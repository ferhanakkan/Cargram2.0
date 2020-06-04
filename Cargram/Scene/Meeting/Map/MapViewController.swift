//
//  MapViewController.swift
//  Cargram
//
//  Created by Ferhan Akkan on 31.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController {
    
    var mapView = GMSMapView()
    let locationManager = CLLocationManager()
    var customView: PickerCardViewController? = PickerCardViewController()
    var type: Type?
    let mapViewModel = MapViewModel()
    var delegate: SelectedArea? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocation()
        setMapView()
        setSearchButton()
    }
}

//MARK: - SetUI

extension MapViewController {
    
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
    
    private func setSearchButton() {
        let searchView = UIView()
        searchView.backgroundColor = .white
        searchView.shadowAndCorner(radius: 27.5, shadowRadius: 27.5, opacity: 0.3, color: .black, width: 1, height: 1)
        let image = UIImageView()
        self.view.addSubview(searchView)
        searchView.snp.makeConstraints { (make) in
            make.height.width.equalTo(55)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(75)
            make.trailing.equalToSuperview().inset(10)
        }
        image.image = UIImage(named: "search-1")
        searchView.addSubview(image)
        image.snp.makeConstraints { (make) in
            make.height.width.equalTo(25)
            make.center.equalToSuperview()
        }
        
        let gest = UITapGestureRecognizer(target: self, action: #selector(searchPressed))
        searchView.isUserInteractionEnabled = true
        searchView.addGestureRecognizer(gest)
        
    }
    
}

//MARK: - Actions

extension MapViewController {
    
    @objc private func searchPressed() {
        let vc = GMSAutocompleteViewController()
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    private func createPickerCardViewAnimation() {
        self.view.addSubview(customView!)
        customView!.setView()
        
        self.customView!.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(50)
            make.height.equalTo(UIScreen.main.bounds.height*0.3)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
            self.customView!.snp.makeConstraints { (make) in
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
    
    private func deletePickerCardViewAnimation() {
        if customView != nil {
            
            self.customView!.snp.makeConstraints { (make) in
                make.leading.trailing.equalToSuperview()
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
                make.height.equalTo(UIScreen.main.bounds.height*0.3)
            }
            
            UIView.animate(withDuration: 1, animations: {
                self.view.layoutIfNeeded()
            }, completion: { [unowned self]_ in
                self.customView?.removeFromSuperview()
                self.customView = nil
            })
        }
        mapView.clear()
    }
    

    
    private func createMarker(coordinate: CLLocationCoordinate2D) {
        mapView.clear()
        let marker = GMSMarker(position: coordinate)
        let markerImage = UIImage(named: "marker")!
        let image = UIImageView(image: markerImage)
        image.frame.size = CGSize(width: 40, height: 40)
        marker.iconView = image
        marker.map = mapView
    }
    
    private func createPickerCard(coordinate: CLLocationCoordinate2D) {
        plotMarker(AtCoordinate: coordinate, onMapView: mapView)
        customView = PickerCardViewController()
        customView?.delegate = self
        customView!.type = type!
        self.view.addSubview(customView!)
        customView!.setView()
        customView!.latitude = coordinate.latitude
        customView!.longitude = coordinate.longitude
        customView!.title.text = "Destination"
         mapViewModel.getLocationAddress(coordinate: coordinate, completion: { [unowned self](address) in
            self.customView!.subtitle.text = address
        })
    }
    
}

//MARK: - Select Area Protocol

extension MapViewController: SelectedArea {
    func selectedArea(latitude: Double, longitude: Double, address: String) {
        delegate?.selectedArea(latitude: latitude, longitude: longitude, address: address)
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - Core Locations

extension MapViewController: CLLocationManagerDelegate {
    
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

extension MapViewController: GMSAutocompleteViewControllerDelegate, GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if !mapViewModel.doesPickerCardOnScreen {
            createPickerCardViewAnimation()
        }
        return true
    }
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        createPickerCard(coordinate: coordinate)
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        deletePickerCardViewAnimation()
    }
    
    private func plotMarker(AtCoordinate coordinate : CLLocationCoordinate2D, onMapView vwMap : GMSMapView) {
        createMarker(coordinate: coordinate)
    }
    
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        dismiss(animated: true, completion: nil)
        
        let cord2D = CLLocationCoordinate2D(latitude: (place.coordinate.latitude), longitude: (place.coordinate.longitude))

        createPickerCard(coordinate: cord2D)
        createMarker(coordinate: cord2D)
        self.mapView.camera = GMSCameraPosition.camera(withTarget: cord2D, zoom: 15)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
}

