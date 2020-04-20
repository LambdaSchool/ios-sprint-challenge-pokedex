//
//  ViewController.swift
//  constraints
//
//  Created by Thomas Sabino-Benowitz on 11/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupSubviews()
    }
    
    func setupSubviews() {
        let blueView = UIView()
        blueView.backgroundColor = .blue
        blueView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blueView)

        
        
        
//        let blueLeadingConstraint = NSLayoutConstraint(item: blueView,
//                                                       attribute: .leading,
//                                                       relatedBy: .equal,
//                                                       toItem: view.safeAreaLayoutGuide,
//                                                       attribute: .leading,
//                                                       multiplier: 1,
//                                                       constant: 20)
//        
//
        let blueLeadingConstraint = blueView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        let blueCenterYConstraint = blueView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
        let blueHeightConstraint = blueView.heightAnchor.constraint(equalToConstant: 100)
        let blueWidthConstraint = blueView.widthAnchor.constraint(equalTo: blueView.heightAnchor, multiplier: 2)
        
//        let blueCenterYConstraint = NSLayoutConstraint(item: blueView,
//                                                       attribute: .centerY,
//                                                       relatedBy: .equal,
//                                                       toItem: view.safeAreaLayoutGuide,
//                                                       attribute: .centerY,
//                                                       multiplier: 1,
//                                                       constant: 0)
//        
//        let blueHeightConstraint = NSLayoutConstraint(item: blueView,
//                                                      attribute: .height,
//                                                      relatedBy: .equal,
//                                                      toItem: nil,
//                                                      attribute: .notAnAttribute,
//                                                      multiplier: 1,
//                                                      constant: 100)
//        
//        let blueWidthConstraint = NSLayoutConstraint(item: blueView,
//                                                     attribute: .width,
//                                                     relatedBy: .equal,
//                                                     toItem: blueView,
//                                                     attribute: .height,
//                                                     multiplier: 2,
//                                                     constant: 1)
        NSLayoutConstraint.activate([blueLeadingConstraint, blueCenterYConstraint, blueWidthConstraint, blueHeightConstraint])
    }


}

