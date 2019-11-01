//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Niranjan Kumar on 11/1/19.
//  Copyright © 2019 Nar Kumar. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
//        didSet{
//            updateViews()
//        }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self


    }
    
    private func updateViews() {
        if let pokemon = pokemon {
            navigationItem.title = pokemon.name
            pokemonNameLabel.text = pokemon.name
            idLabel.text  = "\(pokemon.id)"
            typesLabel.text = pokemon.types.description
            abilitiesLabel.text = pokemon.types.description
        }
    }
    

    @IBAction func saveTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        guard let pokemonController = pokemonController else { return }
        
        pokemonController.savePokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    
    
}





extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let pokemonController = pokemonController else { return }
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        pokemonController.getPokemon(searchTerm: searchTerm) { (result) in
                DispatchQueue.main.async {
                    self.updateViews()
            }
        }
    
    }
}
