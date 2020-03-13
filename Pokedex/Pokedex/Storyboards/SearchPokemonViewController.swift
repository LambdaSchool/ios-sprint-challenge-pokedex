//
//  SearchPokemonViewController.swift
//  Pokedex
//
//  Created by Bhawnish Kumar on 3/13/20.
//  Copyright © 2020 Bhawnish Kumar. All rights reserved.
//

import UIKit

class SearchPokemonViewController: UIViewController {
    
    var pokemonController: PokemonController!
    var pokemonDetailViewController: PokemonDetailViewController?
    
    var pokemon: Pokemon? {
        didSet {
            pokemonDetailViewController?.pokemon = pokemon
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var savePokemon: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func savePokemonAction(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        if pokemonController.searchResults.contains(pokemon) {
            pokemonController.searchResults.append(pokemon)
        }
        self.navigationController?.popViewController(animated: true)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toDetailSegue",
        let detailVC = segue.destination as? PokemonDetailViewController else { return }
        
        detailVC.pokemonController = self.pokemonController
        detailVC.pokemon = self.pokemon
        self.pokemonDetailViewController = detailVC
    }
    

}

extension SearchPokemonViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
                
        pokemonController.getPokemon(for: searchTerm) { result in
            do {
                let pokemon = try result.get()
                self.pokemon = pokemon
            } catch {
                self.pokemon = nil
            }
        }
    }
}
