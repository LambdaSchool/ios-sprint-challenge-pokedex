//
//  PokeDetailViewController.swift
//  Pokedex
//
//  Created by Hector Steven on 5/10/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class PokeDetailViewController: UIViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
		searchBar.delegate = self

    }
    
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let text = searchBar.text else { return }
		print(text)
		
		
	}
	
	
	@IBOutlet var pokeLabel: UILabel!
	@IBOutlet var pokeidLabel: UILabel!
	@IBOutlet var pokeAbilitiesLabel: UILabel!
	@IBOutlet var pokeImageView: UIImageView!
	@IBOutlet var searchBar: UISearchBar!
	var pokeController: PokeController?
}
