//
//  Helpers.swift
//  Pokédex
//
//  Created by Jason Modisett on 9/14/18.
//  Copyright © 2018 Jason Modisett. All rights reserved.
//

import Foundation
import UIKit

// Reuse identifiers
enum ReuseIdentifiers: String {
    case savedPokemon = "SavedPokemonCell"
}

// HTTP method enum
enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

// Personal UILabel extension to increase kerning on labels
extension UILabel {
    
    func kern(_ value: CGFloat) {
        if let labelText = text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(NSAttributedStringKey.kern, value: value, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}
