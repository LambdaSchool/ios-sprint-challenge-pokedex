//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Hunter Oppel on 4/10/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    // MARK: Outlets

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var spriteImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitesLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    
    // MARK: - Properties
    
    var pokemon: Pokemon?
    
    private let viewModel = PokemonDetailViewModel()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let pokemon = pokemon else { return }
        getPokemonSprite(for: pokemon)
    }
    
    func updateViews(for pokemon: Pokemon) {
        self.title = pokemon.name.uppercased()
        nameLabel.text = pokemon.name.uppercased()
        idLabel.text = String("ID: \(pokemon.id)")
        
        var abilitesStringArray = [String]()
        for ability in pokemon.abilities {
            abilitesStringArray.append(ability.ability.name)
        }
        abilitesLabel.text =  "Abilites: \(abilitesStringArray.joined(separator: ", "))"
        
        var typesStringArray = [String]()
        for type in pokemon.types {
            typesStringArray.append(type.type.name)
        }
        typesLabel.text = "Types: \(typesStringArray.joined(separator: ", "))"
    }
    
    func getPokemonSprite(for pokemon: Pokemon) {
        viewModel.getPokemon(with: pokemon.name) { result in
            switch result {
            case .successfulWithPokemon(let pokemon):
                self.updateViews(for: pokemon)
            case .successfulWithSprite(let sprite):
                self.spriteImage.image = sprite
            case .failure(let message):
                print(message)
            }
        }
    }
}
