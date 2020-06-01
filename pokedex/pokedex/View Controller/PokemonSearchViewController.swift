//
//  PokemonSearchViewController.swift
//  pokedex
//
//  Created by Sammy Alvarado on 5/17/20.
//  Copyright © 2020 Sammy Alvarado. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {
    
    var apiController: APIController?


    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
   
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
//        hideViews()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else {return}
        apiController?.fetchPokemon(searchTerm: searchTerm) { (pokemon) in
            guard let searchedPokemon = try? pokemon.get() else {return}
            DispatchQueue.main.async {
                self.pokemon = searchedPokemon
            }
        }
    }
    //Hide storyboard items not needed to show on initial view
//    func hideViews() {
//        saveButton.isEnabled = false
//        pokemonName.isHidden = true
//        pokemonIDLabel.isHidden = true
//        pokemonTypeLabel.isHidden = true
//    }
    func updateViews() {
        guard isViewLoaded else {return}
        guard let pokemon = pokemon else {return}
//        saveButton.isEnabled = true
//        pokemonName.isHidden = false
//        pokemonIDLabel.isHidden = false
//        pokemonTypeLabel.isHidden = false
        title = pokemon.name.capitalized
        guard let pokemonImageData = try? Data(contentsOf: pokemon.sprites.frontDefault) else {return}
        pokemonImageView.image = UIImage(data: pokemonImageData)
        pokemonNameLabel.text = pokemon.name.capitalized
        idLabel.text = "ID: \(pokemon.id)"
        var types = ""
        let typeArray = pokemon.types
        for type in typeArray {
            types.append("Type: \(type.type.name.capitalized)")
        }
        typesLabel.text = types
    }
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let pokemonToBeSaved = pokemon else {return}
        apiController?.addPokemon(pokemon: pokemonToBeSaved)
        navigationController?.popToRootViewController(animated: true)
    }
    
    

}
