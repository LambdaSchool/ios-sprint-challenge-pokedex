//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Dillon P on 9/14/19.
//  Copyright © 2019 Lambda iOSPT2. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {
    
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonIdLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    
    
    var pokemon: Pokemon?
    let pokemonSearchController = PokemonController()
    
    override func viewDidLoad() {
        pokemonSearchBar.delegate = self
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    }
    
    
    private func updateViews() {
        guard let pokemon = pokemon else { return }
        pokemonName.text = pokemon.name
//        pokemonIdLabel.text = "\(pokemon.id)"
//        pokemonTypeLabel.text = pokemon.types
    }

}

extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        let pokemonName = searchTerm.lowercased()
        
        pokemonSearchController.searchForPokemon(with: pokemonName) { (_) in
            self.pokemon = self.pokemonSearchController.pokemon
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
}
