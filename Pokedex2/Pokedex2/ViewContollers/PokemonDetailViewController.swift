//
//  PokemonDetailViewController.swift
//  Pokedex2
//
//  Created by Clean Mac on 7/19/20.
//  Copyright © 2020 LambdaStudent. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var saveButtom: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        if let pokemon = pokemon {
            self.updateViews(with: pokemon)
            saveButton.isHidden = true
            searchBar.isHidden = true
        }
        
        // Do any additional setup after loading the view.
    }
    func getPokemonDetails() {
        guard let pokemonController = pokemonController,
            let pokemon = pokemon else { return }
        
        pokemonController.fetchPokemon(with: pokemon, completion:(result) in
            switch result {
            case .success(let pokemon):
            DispatchQueue.main.async {
            self.updateViews(with: searchterm)
            }
            pokemonController.fetchImage(at: pokemon.imageURL) { (result) in
            if let image = try? result.get() {
            DispatchQueue.main.async {
            self.imageView.image = image
            }
            }
            }
            case .failure(let error):
            print("Error fetching pokemon details \(error)")
        }
    }
}

func updateViews(with pokemon: Pokemon) {
    
}


extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        searchBar.resignFirstResponder()
        guard let pokemonController = pokemonController else { return }
        pokemonController.
    }
}
