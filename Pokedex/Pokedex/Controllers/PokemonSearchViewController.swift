//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Austin Cole on 12/18/18.
//  Copyright © 2018 Austin Cole. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate{
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonSpriteImage: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonSearchBar.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = pokemonSearchBar.text?.lowercased(), !searchTerm.isEmpty else {return}
        Model.shared.pokemonNetworkingClient.fetchPokemon(searchTerm: searchTerm) { (error) in
            if let error = error {
                NSLog("could not call fetchPokemon method in pokemonSearchViewController: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
        searchBar.text = nil
    }
    
    @IBAction func savePokemon(_ sender: Any) {
        Model.shared.savePokemon()
    }
    

    func updateViews() {
        DispatchQueue.main.async {
            guard let pokemon = Model.shared.pokemon else {return}
            guard let url = URL(string: (pokemon.sprites.frontDefault)), let imageData = try? Data(contentsOf: url) else {return}
            self.pokemonSpriteImage.image = UIImage(data: imageData)
            self.pokemonNameLabel.text = pokemon.name.capitalized
            self.idLabel.text = "ID: \(pokemon.id)"
            let pokemonAbilities = pokemon.abilities.map({$0.ability.name
            }).joined(separator: ", ")
            self.abilitiesLabel.text = "Abilities: \(pokemonAbilities)"
            let pokemonTypes = pokemon.types.map({$0.type.name
            }).joined(separator: ", ")
            self.typesLabel.text = "Types: \(pokemonTypes)"
        }
    }
    
    
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
