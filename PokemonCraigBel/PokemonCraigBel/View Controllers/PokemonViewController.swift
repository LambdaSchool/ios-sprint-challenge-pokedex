//
//  PokemonViewController.swift
//  PokemonCraigBel
//
//  Created by Craig Belinfante on 7/19/20.
//  Copyright © 2020 Craig Belinfante. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController, UITableViewDelegate {
    
    var pokemonController: PokemonController?
    var namePokemon: String?

    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonID: UILabel!
    @IBOutlet weak var pokemonType: UILabel!
    @IBOutlet weak var pokemonAbilities: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBAction func savePokemon(_ sender: UIButton) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPokemonDetails()

        // Do any additional setup after loading the view.
    }
    
    func getPokemonDetails() {
        guard let pokemonController = pokemonController,
            let pokemonNames = pokemonName else { return }
        pokemonController.searchPokemon { (result) in
            switch result {
            case .success(let pokemon):
                DispatchQueue.main.async {
           //         self.updateViews(with: pokemon)
                }
            /*    pokemonController.fetchImage(at:  ) { (result) in
                    if let image = try? result.get() {
                        DispatchQueue.main.async {
                            self.pokemonImage.image = image
                        }
                    }
                }
 */
            case .failure(let error):
                print("Error \(error)")
                
            }
        }
    }
    
    func updateViews(with pokemon: Pokemon) {
        title = pokemon.name
        pokemonName.text = pokemon.name
        pokemonID.text = pokemon.id
     //   pokemonType.text = pokemon.types
     //   pokemonAbilities.text = pokemon.abilities
     //   pokemonImage.image =
        
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
