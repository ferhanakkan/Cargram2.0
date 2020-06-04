//
//  MapViewModel.swift
//  Cargram
//
//  Created by Ferhan Akkan on 31.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import Foundation
import GoogleMaps
import GooglePlaces

class MapViewModel {
    
    var doesPickerCardOnScreen = false
    var eventArray: [EventModel] = []
    
    func getLocationAddress(coordinate: CLLocationCoordinate2D, completion: @escaping(String) -> Void) {
        let geocoder = GMSGeocoder()
        var selectedAddress = ""
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard
                let address = response?.firstResult(),
                let _ = address.lines
                else {
                    return
            }
            selectedAddress = address.lines![0]
            completion(selectedAddress)
        }
    }
    
}
