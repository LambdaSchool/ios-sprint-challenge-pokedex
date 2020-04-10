//
//  PokemonViewController.swift
//  iOS-Pokedex
//
//  Created by Cameron Collins on 4/10/20.
//  Copyright © 2020 Cameron Collins. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController, UISearchBarDelegate {

    //Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.autocapitalizationType = .none
        updateViews()
    }
    
    //Variables
    var delegate: PokemonTableViewController?
    var pokemonController: PokemonController?
    var displayedPokemon: PokemonTesting?
    var selectedRow: Int?

    
    //Actions
    @IBAction func buttonPressed(_ sender: UIButton) {
        if selectedRow == nil {
            guard let pokemon = displayedPokemon else { return }
            pokemonController?.pokemonAdded.append(pokemon)
            delegate?.updateViews()
            navigationController?.popViewController(animated: true)
        }
        
        if let selectedRow = selectedRow {
            guard let pokemon = displayedPokemon else { return }
            pokemonController?.pokemonAdded[selectedRow] = pokemon
            delegate?.updateViews()
            navigationController?.popViewController(animated: true)
        }
    }
    
    
    //Functions
    func updateViews() {
        getImage()
        guard let displayedPokemon = displayedPokemon else { return }
        
        //Update: name, id, type, abilities, sprite
        title = displayedPokemon.name
        nameLabel.text = displayedPokemon.name
        idLabel.text = "ID: " + String(displayedPokemon.id)
        typeLabel.text = "Type: " + displayedPokemon.types[0].type.name
        
        var abilities = "Abilities: "
        for i in 0...displayedPokemon.abilities.count - 1 {
            if i == displayedPokemon.abilities.count - 1 {
                abilities += "\(displayedPokemon.abilities[i].ability.name)"
            } else {
                abilities += "\(displayedPokemon.abilities[i].ability.name), "
            }
        }
        abilitiesLabel.text = abilities
    }
    
    
    //Grabs the image for the pokemon
    func getImage() {
        guard let pokemonController = pokemonController else { return }
        pokemonController.pokemon = displayedPokemon
        guard let pokemon = pokemonController.pokemon else { return }
        guard let url = URL(string: pokemon.sprites.frontDefault) else { return }
        pokemonController.convertImage(url: url) {
            DispatchQueue.main.async {
                self.imageView.image = pokemonController.currentImage
            }
        }
    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        guard let pokemonController = pokemonController else { return }
        pokemonController.getPokemon(name: text) {
            DispatchQueue.main.async {
                self.displayedPokemon = self.pokemonController?.pokemon
                self.updateViews()
            }
        }
    }
}
