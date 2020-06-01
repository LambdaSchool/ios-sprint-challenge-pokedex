//
//  PokemonDetailViewController.swift
//  pokedex
//
//  Created by Sammy Alvarado on 5/17/20.
//  Copyright © 2020 Sammy Alvarado. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var apiController: APIController?
    var pokemon: Pokemon?{
        didSet{
            updateViews()
        }
    }
    
    
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var idNumberLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

        // Do any additional setup after loading the view.
    }
    
    
    // I dont need func to get pokemon detial, my fetch in api controler is already doing that. 
//    func getPokeDetails() {
//        guard let apiController = apiController,
//            let pokemon = self.pokemon else { return }
//        apiController.fetchPokemon(searchTerm: pokemon) { (result) in
//            if let pokemon = try? result.get() {
//                DispatchQueue.main.async {
//                    self.updateViews(with: pokemon)
//                }
//
//            }
//        }
//    }
    
    
    func updateViews() {
         guard isViewLoaded,
             let pokemon = pokemon else{return}
         guard let pokemonImageData = try? Data(contentsOf: pokemon.sprites.frontDefault) else {return}
         pokemonImageView.image = UIImage(data: pokemonImageData)
         pokemonNameLabel.text = pokemon.name.capitalized
         idNumberLabel.text = "ID: \(pokemon.id)"
         title = pokemon.name
         var types = ""
         let typeArray = pokemon.types
         for type in typeArray {
             types.append("Type: \(type.type.name.capitalized)")
         }
         typeLabel.text = types
     }
    
//    private func updateViews( with pokemon: Pokemon) {
//        title = pokemon.name
//        idNumberLabel.text = "ID: \(pokemon.id)"
//        typeLabel.text = "Type: \(pokemon.types)"
//        abilitiesLabel.text = "Abilites"
//    }
    

}
