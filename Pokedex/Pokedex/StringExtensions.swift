//
//  StringExtensions.swift
//  Pokedex
//
//  Created by Isaac Lyons on 10/4/19.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
