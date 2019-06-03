//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Stephanie Bowles on 6/2/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var pokeIDLabel: UILabel!
    
    @IBOutlet weak var pokeTypesLabel: UILabel!
    
    
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    @IBOutlet weak var spriteView: UIImageView!
    //    var pokemonController : PokemonController?
    var pokemon: Pokemon? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        navigationItem.title = pokemon?.name.capitalized
        // Do any additional setup after loading the view.
    }
    func updateViews(){
        guard let pokemon = pokemon else { return }
        
        pokeNameLabel.text = pokemon.name.capitalized
        pokeIDLabel.text = String("ID: \(pokemon.id)")
        
        
        let abilities: [String] = pokemon.abilities.map { $0.ability.name }
        abilitiesLabel.text = "Abilities: \(abilities.joined(separator: "\n"))"
        
        let type: [String] = pokemon.types.map { $0.type.name }
        pokeTypesLabel.text = "Type(s): \(type.joined(separator: ", "))"
        
        guard let url = URL(string: pokemon.sprites.back_default),
            let pokemonImageData = try? Data(contentsOf: url) else { return }
        spriteView.image = UIImage(data: pokemonImageData)
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
