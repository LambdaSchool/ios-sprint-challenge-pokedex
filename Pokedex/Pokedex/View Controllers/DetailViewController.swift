//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Bobby Keffury on 9/14/19.
//  Copyright © 2019 Bobby Keffury. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - Outlets

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    //MARK: - Properties
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
        
    }
    
    
    
    
    //updateViews
    private func updateViews() {
        
        guard let pokemon = pokemon else {
            title = nil
            titleLabel.text = nil
            typesLabel.text = nil
            abilitiesLabel.text = nil
            idLabel.text = nil
            
            return
        }
        
        title = pokemon.name.capitalized
        titleLabel.text = pokemon.name.capitalized
        idLabel.text = "\(pokemon.id)"
        let types = pokemon.types.map { $0.type.name }.joined(separator: ", ")
        typesLabel.text = "\(types)"
        let abilities = pokemon.abilities.map { $0.ability.name }.joined(separator: ", ")
        abilitiesLabel.text = "\(abilities)"
        pokemonController?.fetchImage(at: pokemon.sprites.front_default, completion: { (result) in
            
            do {
                let result = try result.get()
                DispatchQueue.main.async {
                    self.imageView.image = result
                }
                
            } catch {
                print("Error getting image: \(error)")
            }
            
        })
        
        
        
        
    }

    
}
