//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Cody Morley on 4/10/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        // Do any additional setup after loading the view.
        print("hello world")
    }
    
    @IBAction func savePokemon(_ sender: Any) {
        guard let unwrappedPokemon = pokemon else { return }
        pokemonController?.savePokemon(pokemon: unwrappedPokemon)
        
        navigationController?.popToRootViewController(animated: true)
    }
    

    func updateViews() {
        //unwrap pokemon object
        guard let pokemon = pokemon else { return }
        
        // give values to IBOutlets to the values of the pokemon object
        nameLabel.text = pokemon.name
        idLabel.text = String("\(pokemon.id)")
        
        
        let imageURLString = pokemon.sprites.front_default
        guard let imageURL = URL(string: imageURLString) else { return }
        do {
            let imageData = try Data(contentsOf: imageURL)
            let image = UIImage(data: imageData)
            imageView.image = image
        } catch {
            print("error loading image \(error) \(error.localizedDescription)")
        }
        
        var typeNames: [String] = []
        for type in pokemon.types {
            typeNames.append(type.type.name)
        }
        let typesString = typeNames.joined(separator: ", ")
        typesLabel.text = typesString
        
        var abilityNames: [String] = []
        for ability in pokemon.abilities {
            abilityNames.append(ability.ability.name)
        }
        let abilitiesString = abilityNames.joined(separator: ", ")
        abilitiesLabel.text = abilitiesString
    }
}

extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        pokemonController?.getPokemon(for: text, completion: { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let pokemon):
                print(pokemon)
                self.pokemon = pokemon
                
                DispatchQueue.main.async {
                    self.updateViews()
                }
            }
        })
    }
}
