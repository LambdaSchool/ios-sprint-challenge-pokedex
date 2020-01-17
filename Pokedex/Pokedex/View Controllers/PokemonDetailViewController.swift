//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Michael on 1/17/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    var pokemonController: PokemonController? {
        didSet {
            updateViews()
        }
    }
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    @IBOutlet weak var savePokemonButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        searchBar.delegate = self
    }
    
    @IBAction func savePokemonTapped(_ sender: Any) {
        if let pokemon = pokemon {
            pokemonController?.savePokemon(name: pokemon.name, id: pokemon.id, abilities: pokemon.abilities, type: pokemon.types, sprites: pokemon.sprites)
        }
        navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func searchOrDetail() {
        guard let imageView = pokemonImageView, let nameLabel = pokemonNameLabel, let idLabel = pokemonIDLabel,
        let typesLabel = pokemonTypesLabel, let abilitiesLabel = pokemonAbilitiesLabel, let savePokemon =
        savePokemonButton  else { return }
        if pokemon == nil {
            title = "Pokemon Search"
            imageView.isHidden = true
            nameLabel.isHidden = true
            idLabel.isHidden = true
            typesLabel.isHidden = true
            abilitiesLabel.isHidden = true
            savePokemon.isHidden = true
            
        } else {
            guard let pokemon = pokemon else { return }
            title = pokemon.name
            imageView.isHidden = false
            nameLabel.isHidden = false
            idLabel.isHidden = false
            typesLabel.isHidden = false
            abilitiesLabel.isHidden = false
            savePokemon.isHidden = false
        }
    }
    
    func updateViews() {
        searchOrDetail()
        guard let pokemon = pokemon, let nameLabel = pokemonNameLabel, let idLabel = pokemonIDLabel, let typesLabel = pokemonTypesLabel, let abilityLabel = pokemonAbilitiesLabel, let imageView = pokemonImageView, let imageURL = URL(string: pokemon.sprites.frontShiny), let imageData = try? Data(contentsOf: imageURL) else { return }
        nameLabel.text = pokemon.name
        idLabel.text = "ID: \(pokemon.id)"
        var abilitiesArray: [String] = []
        var typesArray: [String] = []
        for parentType in pokemon.types {
            typesArray.append(parentType.type.name)
        }
        for parentAbility in pokemon.abilities {
            abilitiesArray.append(parentAbility.ability.name)
        }
        
        typesLabel.text = "Types: \(typesArray)"
        abilityLabel.text = "Abilities: \(abilitiesArray)"
        imageView.image = UIImage(data: imageData)
    }
}

extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let pokemon = searchBar.text?.lowercased() else { return }
        
        pokemonController?.getPokemonDetails(pokemon: pokemon, completion: { result in
            let pokemon = try? result.get()
            DispatchQueue.main.async {
                self.pokemon = pokemon
                self.updateViews()
            }
        })
    }
}
