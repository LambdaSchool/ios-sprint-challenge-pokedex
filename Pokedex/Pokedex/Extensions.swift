//
//  Extensions.swift
//  Pokedex
//
//  Created by Bradley Diroff on 3/13/20.
//  Copyright © 2020 Bradley Diroff. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
