//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Benjamin Hakes on 12/7/18.
//  Copyright © 2018 Benjamin Hakes. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var pokemon: Pokemon?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let pokemon = pokemon else { return }
        nameLabel.text = pokemon.name
        idLabel.text = String(pokemon.id)
        
        var abilitiesString = "Abilities: "
        for each in 0..<(pokemon.abilities.count - 1){
            abilitiesString += "\(pokemon.abilities[each].ability.name), "
        }
        abilitiesString += pokemon.abilities[pokemon.abilities.count - 1].ability.name
        
        abilitiesLabel.text = abilitiesString
        
        var typesString = "Types: "
        for each in 0..<(pokemon.types.count - 1){
            typesString += "\(pokemon.types[each].type.name), "
        }
        typesString += pokemon.types[pokemon.types.count - 1].type.name
        
        typesLabel.text = typesString
        
        let imageUrlString = pokemon.sprites.frontDefault
        
        DispatchQueue.global(qos: .background).async {
            do
            {
                let data = try Data.init(contentsOf: URL.init(string:imageUrlString)!)
                DispatchQueue.main.async {
                    let image: UIImage = UIImage(data: data)!
                    self.pokemonImageView.image = image
                }
            }
            catch {
                // error
                fatalError("unable to get Pokemon picture")
            }
        }
    }

}
