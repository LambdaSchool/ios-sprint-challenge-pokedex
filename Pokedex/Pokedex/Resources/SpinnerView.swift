//
//  SpinnerView.swift
//  Pokedex
//
//  Created by Dillon McElhinney on 9/14/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import UIKit


extension UIViewController {
    /// Displays an activity indicator over the whole of the view passed in, and returns a reference to it.
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activityIndicator = UIActivityIndicatorView.init(style: .whiteLarge)
        activityIndicator.startAnimating()
        activityIndicator.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(activityIndicator)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    /// Removes the given spinner from its super view
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}
