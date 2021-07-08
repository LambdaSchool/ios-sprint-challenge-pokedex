//
//  DetailViewController.swift
//  Networking Sprint Challenge - PokeDex
//
//  Created by Vijay Das on 2/1/19.
//  Copyright © 2019 Vijay Das. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    var pokemonController: PokemonController?

    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }

    // update views with property observer pattern
    

    func updateViews() {
        guard isViewLoaded else { return }
        guard let pokemon = pokemon else { return }
        pokeName.text = pokemon.name
        pokeID.text = "\(pokemon.id)"
        
        let abilityName = pokemon.abilities.map { $0.subAbility.name}
        let typeName = pokemon.type.map { $0.subType}
        
        pokeAbilities.text = abilityName.first
        pokeTypes.text = typeName.first
        
        pokemonController?.fetchImage(for: pokemon, completion: { (data) in
            guard let data = data else { return }
            
            let image = UIImage(data: data)
            self.pokeImage.image = image
 
        })
        
        
    }
    
 

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

        // Do any additional setup after loading the view.
    }
    
// OUTLETS
    
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var pokeName: UILabel!
    @IBOutlet weak var pokeID: UILabel!
    @IBOutlet weak var pokeTypes: UILabel!
    @IBOutlet weak var pokeAbilities: UILabel!
}


