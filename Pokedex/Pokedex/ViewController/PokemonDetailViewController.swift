//
//  ViewController.swift
//  Pokedex
//
//  Created by Bradley Yin on 8/9/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    var apiController: APIController!
    
    var pokemon: Pokemon?
    
    var fromCell = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        title = "New Pokemon"
        saveButton.isHidden = true
        if fromCell {
            searchBar.isHidden = true
            guard let pokemon = pokemon else { return }
            updateViews(with: pokemon)
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        apiController.pokemons.append(pokemon)
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateViews(with pokemon: Pokemon) {
        title = pokemon.name
        nameLabel.text = pokemon.name
        idLabel.text = "ID: \(pokemon.id)"
        var typeList = ""
        for type in pokemon.types {
            //if type == pokemon.types[pokemon.types.count - 1] {
            typeList.append("\(type.type["name"] ?? ""), " )
            //} else {
                //typeList.append("\(type.type["name"])" ?? "")
           // }
            
        }
        typeLabel.text = "Type: \(typeList)"
        var abilityList = ""
        for ability in pokemon.abilities {
            abilityList.append("\(ability.ability["name"] ?? ""), " )
        }
        abilityLabel.text = "Abilities: \(abilityList)"
        
        guard let imageData = pokemon.imageData else { return }
        self.pokemonImageView.image = UIImage(data: imageData)
    }
    

}

extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        let searchTerm = text.lowercased()
        apiController.searchPokemon(with: searchTerm) { (result) in
            guard let pokemon = try? result.get() else { return }
            self.apiController.fetchImage(imageURL: pokemon.sprites["front_default"]!, completion: { (dataResult) in
                guard let data = try? dataResult.get() else { return }
                DispatchQueue.main.async {
                    var changePokemon = pokemon
                    changePokemon.imageData = data
                    self.pokemon = changePokemon
                    self.updateViews(with: changePokemon)
                    self.saveButton.isHidden = false
                }
            })
        }
    }
}

