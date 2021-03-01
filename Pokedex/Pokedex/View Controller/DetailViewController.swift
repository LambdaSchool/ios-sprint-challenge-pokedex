//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Craig Belinfante on 1/4/21.
//

import UIKit

class DetailViewController: UIViewController, UISearchBarDelegate {
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    //Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonID: UILabel!
    @IBOutlet weak var pokemonType: UILabel!
    @IBOutlet weak var pokemonAbilities: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        updateViews()
    }
    
    //Save Action
    @IBAction func savePokemonButtonPressed(_ sender: UIButton) {
        guard let pokemon = pokemon else {return}
        
        pokemonController?.save(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        
        if let pokemon = pokemon {
            pokemonNameLabel.text = pokemon.name.capitalized
            pokemonID.text = "\(pokemon.id)"
            pokemonType.text = "\(pokemon.types.joined(separator: ", "))"
            pokemonAbilities.text = "\(pokemon.ability.joined(separator: ", "))"
//            pokemonImage.image = pokemon.fetchedImage
            
        } else {
            //setup for search - make all the labels invisible
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        searchBar.resignFirstResponder()
        guard let pokemonController = pokemonController else { return }
        pokemonController.fetchPokemon(with: searchText) { (error) in
            if let error = error {
                print("Could not search for pokemon: \(error)")
            } else {
                guard let pokemon = self.pokemon else {return}
                self.pokemonController?.save(pokemon: pokemon)
            }
            self.updateViews()
        }
    }
}

