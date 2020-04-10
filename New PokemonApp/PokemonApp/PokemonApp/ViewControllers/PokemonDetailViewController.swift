//
//  PokemonDetailViewController.swift
//  PokemonApp
//
//  Created by Bhawnish Kumar on 4/10/20.
//  Copyright © 2020 Bhawnish Kumar. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    var pokemonController: PokemonController?
    
       var pokemon: Pokemon? { didSet { updateViews() }}
    
    override func viewDidLoad() {
        super.viewDidLoad()
updateViews()
      
    }
    
    private func updateImageView() {
        guard let pokemon = pokemon, let pokemonImage = pokemon.sprites.frontDefault else { return }
        guard let newPokemonController = pokemonController  else { return }
       
                 
        newPokemonController.fetchImage(at: pokemonImage) { (result) in
               DispatchQueue.main.async {
                   switch result {
                   case .success(let image):
                       self.imageView.image = image
                   case .failure(let error):
                       NSLog("\(error)")
                   }
               }
           }
       }
    
    private func updateViews() {
           guard let pokemon = pokemon, isViewLoaded else { return }
           
        nameLabel.text = pokemon.name
           idLabel.text = "ID: \(pokemon.id)"
           
           let types = pokemon.types.map { $0.type.name }.joined(separator: ", ")
           typesLabel.text = "Types: \(types)"
           
        let abilities = pokemon.abilities.map { $0.ability.name }
           abilitiesLabel.text = "Abilities: \(abilities)"
           
        
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
