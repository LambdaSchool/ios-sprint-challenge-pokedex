//
//  PokemonDetailViewController.swift
//  PokeDex
//
//  Created by David Williams on 5/17/20.
//  Copyright © 2020 david williams. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController, UISearchBarDelegate {
    
    var pokemonController: PokedexController?
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }

    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        updateViews()
        hideViews()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        pokemonController?.savePokemon(newPokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    func hideViews() {
        saveButton.isHidden = true
        guard pokemon != nil else { return }
        searchBar.isHidden = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        pokemonController?.searchForPokemonWith(searchTerm: searchTerm, completion: { (result) in
            guard let pokemon = try? result.get() else { return }
            DispatchQueue.main.async {
                self.pokemon = pokemon
                self.saveButton.isHidden = false
            }
        })
    }
    
    func updateViews() {
        guard isViewLoaded else { return }
        guard let pokemon = pokemon else {
            title = "Pokemon Search"
            pokemonNameLabel.text = ""
            idLabel.text = ""
            abilitiesLabel.text = ""
            typesLabel.text = ""
            return
        }
        title = pokemon.name.capitalized
        pokemonNameLabel.text = pokemon.name.capitalized
        idLabel.text = "\(pokemon.id)"
        abilitiesLabel.text = pokemon.abilities.map( { $0.ability.name.capitalized }).joined(separator: ", ")
        typesLabel.text = pokemon.types.map( { $0.type.name.capitalized }).joined(separator: ", ")
        self.pokemonController?.fetchImage(at: pokemon.sprites.frontDefault, completion: { (image) in
            DispatchQueue.main.async {
                self.pokemonImage.image = image
            }
        })
    }
}


