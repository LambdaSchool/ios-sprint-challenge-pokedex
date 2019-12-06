//
//  RoundedButton.swift
//  SprintChallengePokedex
//
//  Created by Chad Rutherford on 12/6/19.
//  Copyright © 2019 lambdaschool.com. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    override func layoutSubviews() {
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        self.setTitle("Save Pokemon", for: .normal)
    }
}
