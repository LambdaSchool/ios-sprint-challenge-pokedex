//
//  PokemonSearchViewController.swift
//  Pokedex-v3
//
//  Created by Austin Potts on 9/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var pokemonName: UILabel!
    
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    
    
    
    var pokemonController: PokemonController?
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
        guard let searchTerm = searchBar.text else {return}
        pokemonController?.getPokemon(searchTerm: searchTerm) { (pokemon) in
            guard let searchedPokemon = try? pokemon.get() else {return}
            DispatchQueue.main.async {
                self.pokemon = searchedPokemon
            }
        }
    }
    
    
    //Hid storyboard items not needed to show on initial view
    func hideViews() {
        saveButton.isEnabled = false
        pokemonName.isHidden = true
        pokemonIDLabel.isHidden = true
        pokemonTypeLabel.isHidden = true
    }
    
    func updateViews() {
        guard isViewLoaded else {return}
        guard let pokemon = pokemon else {return}
        saveButton.isEnabled = true
        pokemonName.isHidden = false
        pokemonIDLabel.isHidden = false
        pokemonTypeLabel.isHidden = false
        title = pokemon.name.capitalized
        guard let pokemonImageData = try? Data(contentsOf: pokemon.sprites.frontDefault) else {return}
        imageView.image = UIImage(data: pokemonImageData)
        pokemonName.text = pokemon.name.capitalized
        pokemonIDLabel.text = "ID: \(pokemon.id)"
        
        var types = ""
        let typeArray = pokemon.types
        
        for type in typeArray {
            types.append("\(type.type.name)")
            
        }
        
        pokemonTypeLabel.text = types
        
    }
  
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let pokemonToBeSaved = pokemon else {return}
        pokemonController?.addPokemon(pokemon: pokemonToBeSaved)
        navigationController?.popToRootViewController(animated: true)
        
        
    }
    
}
