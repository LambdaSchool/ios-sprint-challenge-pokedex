//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Thomas Cacciatore on 5/17/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }
    
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
    }
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
}
