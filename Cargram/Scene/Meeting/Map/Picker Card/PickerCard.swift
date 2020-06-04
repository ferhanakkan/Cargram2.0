//
//  PickerCard.swift
//  Cargram
//
//  Created by Ferhan Akkan on 1.06.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import MapKit

enum Type {
    case selectArea
    case showArea
}

protocol SelectedArea {
    func selectedArea(latitude: Double, longitude: Double, address: String)
}

class PickerCardViewController: UIView {
    
    let mainView = UIView()
    let title = UILabel()
    let subtitle = UILabel()
    var latitude: Double?
    var longitude: Double?
    let showRouteButton = UIButton()
    let selectAreaButton = UIButton()
    var type: Type?
    var delegate: SelectedArea?
    
    func setView() {
        self.backgroundColor = .white
        self.addSubview(title)
        self.addSubview(subtitle)
        setTitle()
        setSubtitle()
                
        type == .showArea ?  setShowRouteButton() : setSelectArea()
    }
    
    private func setTitle() {
        title.textAlignment = .left
        title.font = UIFont.boldSystemFont(ofSize: 15)
        title.textColor = .black
        title.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(40)
        }
    }
    
    private func setSubtitle() {
        subtitle.textAlignment = .left
        subtitle.font = UIFont.systemFont(ofSize: 12)
        subtitle.textColor = .black
        subtitle.numberOfLines = 0
        subtitle.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.top.equalTo(title.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func setShowRouteButton() {
        self.addSubview(showRouteButton)
        showRouteButton.setTitle("Show Route", for: .normal)
        showRouteButton.backgroundColor = .systemGreen
        showRouteButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        showRouteButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.leading.equalTo(subtitle.snp.trailing).offset(10)
            make.width.equalTo(100)
        }
        showRouteButton.addTarget(self, action: #selector(showRoutePressed), for: .touchUpInside)
    }
    
    private func setSelectArea() {
        self.addSubview(selectAreaButton)
        selectAreaButton.setTitle("Select Area", for: .normal)
        selectAreaButton.backgroundColor = .systemGreen
        selectAreaButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        selectAreaButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.leading.equalTo(subtitle.snp.trailing).offset(10)
            make.width.equalTo(100)
        }
        selectAreaButton.addTarget(self, action: #selector(areaSelected), for: .touchUpInside)
    }
    
    
    @objc func areaSelected() {
        delegate?.selectedArea(latitude: latitude!, longitude: longitude!, address: subtitle.text!)
    }
    
    @objc func showRoutePressed() {
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude!, longitude!)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "\(subtitle.text!)"
        mapItem.openInMaps(launchOptions: options)
    }
}
