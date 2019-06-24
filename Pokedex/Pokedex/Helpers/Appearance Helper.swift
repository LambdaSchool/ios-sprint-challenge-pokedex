//
//  Appearance Helper.swift
//  Pokedex
//
//  Created by Stephanie Bowles on 6/24/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import UIKit

enum AppearanceHelper {
    
    static var pokeRed = #colorLiteral(red: 0.7254901961, green: 0, blue: 0.08235294118, alpha: 1)
    static var pokeBlue = #colorLiteral(red: 0.2549019608, green: 0.6039215686, blue: 0.8823529412, alpha: 1)
    static var pokeBlack = #colorLiteral(red: 0.0556207214, green: 0.1921568627, blue: 0.1289207308, alpha: 1)
    static func setPokedexAppearance(){
        UINavigationBar.appearance().barTintColor = pokeRed
        UIBarButtonItem.appearance().tintColor = .white
        
//        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "pokecircle")
//        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "pokecircle")
//        Can I make the back arrow just in blue?
        
        let textAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.white]
//                               NSAttributedString.Key.shadow: UIColor.blue]
//                               NSAttributedString.Key.strokeWidth: 3.0]
        
        UINavigationBar.appearance().titleTextAttributes = textAttributes
        UINavigationBar.appearance().largeTitleTextAttributes = textAttributes
    }
}
