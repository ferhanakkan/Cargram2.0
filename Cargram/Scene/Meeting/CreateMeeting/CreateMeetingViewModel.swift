//
//  CreateMeetingViewModel.swift
//  Cargram
//
//  Created by Ferhan Akkan on 29.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import Foundation

class CreateMeetingViewModel {
    
    var didDateSetted = false
    var selectedAreaLatitude: Double? = nil
    var selectedAreaLongitude: Double? = nil
    var selectedAreaAddress: String? = nil
    
    let firebase = FirebaseMeetingService()
    
    func createMeeting(title: String, description: String, selectedDate: Date? = nil, completion: @escaping() -> Void) {
        
        if title == "" || description == "" {
            AppManager.shared.messagePresent(title: "OOPS", message: "Please enter title and description", type: .error, isInternet: .nonInternetAlert)
        } else if !didDateSetted {
            AppManager.shared.messagePresent(title: "OOPS", message: "Please select date for event time", type: .error, isInternet: .nonInternetAlert)
        } else if selectedAreaAddress == nil {
            AppManager.shared.messagePresent(title: "OOPS", message: "Please select event location", type: .error, isInternet: .nonInternetAlert)
        } else {
            let doubleTime = Double(selectedDate!.timeIntervalSince1970)
            LoadingView.show()
            firebase.createEvent(title: title, description: description, address: selectedAreaAddress!, timestamp: doubleTime, latitude: selectedAreaLatitude!, longitude: selectedAreaLongitude!) {
                LoadingView.hide()
                completion()
            }
        }
    }
    
}
