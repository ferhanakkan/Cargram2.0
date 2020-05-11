//
//  LoadingView.swift
//  Cargram
//
//  Created by Ferhan Akkan on 11.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit

class LoadingView {
    
    static var currentOverlay : UIView?
    static var currentOverlayTarget : UIView?
    static var loadingActionBar : UIView?
    
    static func show() {
        guard let currentMainWindow = UIApplication.shared.keyWindow else {
            return
        }
        show(currentMainWindow)
    }
    
    static func show(_ overlayTarget : UIView) {
        
        let overlay = UIView()
        overlay.backgroundColor = UIColor.darkGray.withAlphaComponent(0.8)
        overlay.translatesAutoresizingMaskIntoConstraints = false
        
        overlayTarget.addSubview(overlay)
        overlayTarget.bringSubviewToFront(overlay)
        
        overlay.leftAnchor.constraint(equalTo: overlayTarget.leftAnchor, constant: 0.0).isActive = true
        overlay.widthAnchor.constraint(equalTo: overlayTarget.widthAnchor).isActive = true
        overlay.heightAnchor.constraint(equalTo: overlayTarget.heightAnchor).isActive = true
        
        let activityView = UIActivityIndicatorView(style: .whiteLarge)
        activityView.center.x = overlayTarget.center.x
        activityView.center.y = overlayTarget.center.y
        overlayTarget.addSubview(activityView)
        activityView.startAnimating()

        currentOverlay = overlay
        currentOverlayTarget = overlayTarget
        loadingActionBar = activityView
    }
    
    static func hide() {
        if currentOverlay != nil {
            currentOverlay?.removeFromSuperview()
            currentOverlay =  nil
            currentOverlayTarget = nil
            loadingActionBar?.removeFromSuperview()
            loadingActionBar = nil
        }
    }
}
