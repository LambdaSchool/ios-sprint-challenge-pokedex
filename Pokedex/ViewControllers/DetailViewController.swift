//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Chris Price on 3/21/20.
//  Copyright © 2020 com.chrispriiice. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon? //{
//        didSet {
//                self.updateViews()
//        }
  //  }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //updateViews()
        title = pokemon?.name.capitalized
        pokemonNameLabel.text = pokemon?.name.capitalized
        pokemonIDLabel.text = "\(pokemon!.id)"
        pokemonAbilitiesLabel.text = pokemon?.abilities.map({$0.ability.name}).joined(separator: ", ")
        pokemonTypesLabel.text = pokemon?.types.map({$0.type.name}).joined(separator: ", ")
        pokemonController?.fetchImage(urlString: pokemon?.sprites.frontDefault ?? "Womp", completion: { (result) in
            if let pokemonSearchResult = try? result.get() {
                DispatchQueue.main.async {
                    self.pokemonImageView.image = pokemonSearchResult
                }
            }
        })
    }
    
//    func updateViews() {
//        guard let pokemon = pokemon else { return }
//        pokemonNameLabel.text = pokemon.name.capitalized
//        pokemonIDLabel.text = "\(pokemon.id)"
//        pokemonAbilitiesLabel.text = pokemon.abilities.map({$0.ability.name}).joined(separator: ", ")
//        pokemonTypesLabel.text = pokemon.types.map({$0.type.name}).joined(separator: ", ")
//        pokemonController?.fetchImage(urlString: pokemon.sprites.frontDefault, completion: { (result) in
//            if let pokemonSearchResult = try? result.get() {
//                DispatchQueue.main.async {
//                    self.pokemonImageView.image = pokemonSearchResult
//                }
//            }
//        })
//    }
}
