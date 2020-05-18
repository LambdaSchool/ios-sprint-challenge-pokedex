//
//  PokemonSearchViewController.swift
//  PokeDex
//
//  Created by David Williams on 5/16/20.
//  Copyright © 2020 david williams. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    private var pokedexController = PokedexController()
    private var pokemon: [Pokemon] = [] 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        searchBar.delegate = self
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func savePokemonTapped(_ sender: Any) {
    
     //   pokedexController.savePokemon(with: <#T##Pokemon#>)
    }
}

extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        pokedexController.searchForPokemonWith(searchTerm: searchTerm) { (newPokemon) in
            DispatchQueue.main.async {
            self.pokemon = newPokemon
            }
        }
    }
}
