//
//  LoadingViewable.swift
//  SAPGuardianApp
//
//  Created by Tarang Kaneriya on 13/09/21.
//

import UIKit


protocol LoadingViewable {
    func startAnimating()
    func stopAnimating()
}
extension LoadingViewable where Self : UIViewController {
    func startAnimating(){
        let animateLoading = LoadingView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        view.addSubview(animateLoading)
        view.bringSubviewToFront(animateLoading)
        animateLoading.restorationIdentifier = "loadingView"
        animateLoading.center = view.center
        animateLoading.loadingViewMessage = "Loading"
        animateLoading.layer.cornerRadius = 15
        animateLoading.clipsToBounds = true
        animateLoading.startAnimation()
    }
    func stopAnimating() {
        for item in view.subviews
            where item.restorationIdentifier == "loadingView" {
                UIView.animate(withDuration: 0.3, animations: {
                    item.alpha = 0
                }) { (_) in
                    item.removeFromSuperview()
                }
        }
    }
}
