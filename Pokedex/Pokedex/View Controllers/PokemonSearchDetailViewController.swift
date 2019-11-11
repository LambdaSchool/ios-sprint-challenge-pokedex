//
//  PokemonSearchDetailViewController.swift
//  Pokedex
//
//  Created by Craig Swanson on 11/10/19.
//  Copyright © 2019 Craig Swanson. All rights reserved.
//

import UIKit

protocol AddPokemonDelegate {
    func pokeWasAdded(_ pokemons: [Pokemon])
}

class PokemonSearchDetailViewController: UIViewController, UISearchBarDelegate {
    
    // MARK: Properties
    var pokemonController: PokemonController?
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    var delegate: AddPokemonDelegate?

    
    // MARK: Outlets
    @IBOutlet weak var searchField: UISearchBar!
    @IBOutlet weak var pokeName: UILabel!
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var pokeID: UILabel!
    @IBOutlet weak var pokeType: UILabel!
    @IBOutlet weak var pokeAbility: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchField.delegate = self

        // Do any additional setup after loading the view.
    }
    
    // MARK: Actions
    @IBAction func savePokemon(_ sender: UIButton) {
        guard let pokemonController = pokemonController else { return }
        pokemonController.pokemons.append(pokemon!)
        delegate?.pokeWasAdded(pokemonController.pokemons)
    }
    
    // MARK: Methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let pokemonController = pokemonController,
            let searchField = searchField.text else { return }
        
        pokemonController.performSearch(searchTerm: searchField) {
            result in
            if let pokemon = try? result.get() {
                DispatchQueue.main.async {
                    
                    // TODO: Dismiss keyboard
                    self.pokemon = pokemon

                }
                pokemonController.fetchImage(at: pokemon.sprites.front_default) { (result) in
                    if let image = try? result.get() {
                        DispatchQueue.main.async {
                            self.pokeImage.image = image
                        }
                    }
                }
            }
        }
    }
    
    private func updateViews() {
        // Make sure a pokemon exists
        guard let pokemon = pokemon else { return }
        // set the pokemon name label equal to the name.
        pokeName.text = pokemon.name.capitalized
        self.title = pokemon.name.capitalized
        // set the pokemon id equal to the id.
        pokeID.text = ("ID: \(pokemon.id)")
        // the type can be more than one. Iterate through the array and add the name to the label.
        pokeType.text = "Type: "
        for types in pokemon.types {
            let typeName = types.type.name
            pokeType.text = pokeType.text! + typeName + ", "
        }
        // the ability can be more than one. Iterate through the array and add the name to the label.
        pokeAbility.text = "Abilities: "
        for abilities in pokemon.abilities {
            let abilityName = abilities.ability.name
            pokeAbility.text = pokeAbility.text! + abilityName + ", "
        }
    }

}
