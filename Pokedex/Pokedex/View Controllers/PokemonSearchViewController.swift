//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Madison Waters on 12/7/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {

    var pokemon: Pokemon?
    
    @IBOutlet weak var SearchBar: UISearchBar!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    
    @IBAction func saveToPokedex(_ sender: Any) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        Model.shared.search(for: searchTerm.lowercased())
    
        let indexPath = Int()
        let pokemon = Model.shared.pokemon(at: indexPath)
        nameLabel.text = pokemon.name
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    // MARK: - Navigation
    // Not sure I need this. 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cellToDetail" {
            guard let destination = segue.destination as? PokedexTableViewController else { return }
            let indexPath = IndexPath()
            
            let pokemon = Model.shared.pokemon(at: indexPath.row)
            destination.pokemon = pokemon
        }
    }
    

}
