//
//  PokemonDetailViewController.swift
//  pokedexSprintChallenge
//
//  Created by admin on 9/6/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var pokemon: Pokemon?
    var pokemonController = PokemonController()
        
    
    
    override func viewWillAppear(_ animated: Bool) {
        updateViews()
    }
    
    func updateViews() {
        guard let pokemon = pokemon else { return }
        title = pokemon.name
        nameLabel.text = pokemon.name
        idLabel.text = "\(pokemon.id)"
        let pokemonTypes: [String] = pokemon.types.map{ $0.type.name}
        typeLabel.text = "\(pokemonTypes.joined(separator: ", "))"
        let pokemonAbilities: [String] = pokemon.abilities.map{ $0.ability.name}
        abilitiesLabel.text = "\(pokemonAbilities.joined(separator: ", "))"
        
        guard let url = URL(string: pokemon.image.frontDefault),
            let images = try? Data(contentsOf: url) else { return }
        pokemonImageView.image = UIImage(data: images)
        
    }
    
    @IBOutlet weak var saveButton: UIButton!

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
