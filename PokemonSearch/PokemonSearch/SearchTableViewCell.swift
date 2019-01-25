//
//  SearchTableViewCell.swift
//  PokemonSearch
//
//  Created by Jocelyn Stuart on 1/25/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var pokemon: Pokemon?
    
    var pokemonController: PokemonController?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
       /* guard let name = nameLabel.text, let id = Int(idLabel.text!), let types = typeLabel.text, let abilities = abilitiesLabel.text else { return } */
        
        if let pokemon = pokemon {
            pokemonController?.addPokemon(pokemon: pokemon)
            
            /*pokemonController?.create(withName: pokemon.name, and: pokemon.id, andAbility: pokemon.abilities, andType: pokemon.types, completion: { (error) in
                if let error = error {
                    print(error)
                }
            })*/
        
              /*  DispatchQueue.main.async {
                    UINavigationController?.popViewController(animated: true)
                } */
        }
        
        
    }
    
    
    
}
