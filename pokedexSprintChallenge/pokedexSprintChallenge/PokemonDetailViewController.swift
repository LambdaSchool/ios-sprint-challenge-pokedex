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
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        guard isViewLoaded,
            let pokemon = pokemon else { return }
        title = pokemon.name
        nameLabel.text = pokemon.name
        idLabel.text = "\(pokemon.id)"
        typeLabel.text = pokemon.type.types
        abilitiesLabel.text = pokemon.abilities.abilities
        guard let imageData = try? Data(contentsOf: pokemon.image.sprites) else { fatalError() }
        pokemonImageView.image = UIImage(data: imageData)
        
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
