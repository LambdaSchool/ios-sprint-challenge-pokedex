//
//  PokeSearchViewController.swift
//  PokedexApp
//
//  Created by Nelson Gonzalez on 1/24/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class PokeSearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var pokeSearchBar: UISearchBar!
    
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        <#code#>
    }
   
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        
    }
    
}
