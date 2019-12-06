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
    override func layoutSubviews() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 15
    }
}
