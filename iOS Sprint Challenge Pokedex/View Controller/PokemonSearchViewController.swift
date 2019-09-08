//
//  PokemonDetailViewController.swift
//  iOS Sprint Challenge Pokedex
//
//  Created by Andrew Ruiz on 9/6/19.
//  Copyright © 2019 Andrew Ruiz. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {
    
    var pokemonController: PokemonController?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        hideViews()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        pokemonController?.getPokemon(searchTerm: searchTerm) { (pokemon) in
            guard let searchedPokemon = try? pokemon.get() else { return }
            DispatchQueue.main.async {
                self.pokemon = searchedPokemon
            }
        }
    }
    
    func hideViews() {
        saveButton.isEnabled = false
        nameLabel.isHidden = true
    }
    
    func updateViews() {
        guard isViewLoaded else { return }
        guard let pokemon = pokemon else { return }
        saveButton.isEnabled = true
        title = pokemon.name.capitalized + " " + "ID: \(pokemon.id)"
        guard let pokemonImageData = try? Data(contentsOf: pokemon.sprites.frontDefault) else { return }
        imageView.image = UIImage(data: pokemonImageData)
        nameLabel.isHidden = false
        nameLabel.text = pokemon.name.capitalized
        
        
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let pokemonToBeSaved = pokemon else { return }
        pokemonController?.addPokemon(pokemon: pokemonToBeSaved)
        navigationController?.popToRootViewController(animated: true)
    }

}
