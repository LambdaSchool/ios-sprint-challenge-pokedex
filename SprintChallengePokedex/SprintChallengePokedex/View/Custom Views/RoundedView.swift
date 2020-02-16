//
//  RoundedView.swift
//  SprintChallengePokedex
//
//  Created by Chad Rutherford on 12/6/19.
//  Copyright © 2019 lambdaschool.com. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedView: UIView {
    
    /// Function set up to round the corners of the TableView Cell's Container View
    override func layoutSubviews() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 15
    }
}
