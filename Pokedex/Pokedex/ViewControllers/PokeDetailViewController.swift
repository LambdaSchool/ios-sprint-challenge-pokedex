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
		print("searchBar BUtton Clicked")
	}
	
	
	
	@IBOutlet var searchBar: UISearchBar!
	
}
