//
//  PokeMonDetailViewController.swift
//  Pokedex
//
//  Created by Iyin Raphael on 9/21/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
//

import UIKit

class PokeMonDetailViewController: UIViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        pokeController?.fetchPokemon(name: searchTerm, completion: { (error) in
            <#code#>
        })
    }
    
    @IBAction func savePokemon(_ sender: Any) {
    }
    
    var pokemon: Pokemon?
    var pokeController: PokemonController?
    
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
}
