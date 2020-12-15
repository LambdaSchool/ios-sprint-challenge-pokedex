//
//  CardView.swift
//  Jesse's Pokedex
//
//  Created by Jesse Ruiz on 12/15/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    let point: CGSize = CGSize(width: 1, height: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.60
        layer.shadowOffset = point
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
