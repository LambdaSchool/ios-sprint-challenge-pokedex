//
//  PokemonDetailViewController.swift
//  Pokedex-v3
//
//  Created by Austin Potts on 9/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon? {
        didSet{
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    
    func updateViews() {
        guard isViewLoaded,
            let pokemon = pokemon else{return}
        guard let pokemonImageData = try? Data(contentsOf: pokemon.sprites.frontDefault) else {return}
        imageView.image = UIImage(data: pokemonImageData)
        pokemonName.text = pokemon.name.capitalized
        idLabel.text = "ID: \(pokemon.id)"
        title = pokemon.name
        
        var types = ""
        let typeArray = pokemon.types
        
        for type in typeArray {
            types.append("Type: \(type.type.name.capitalized)")
            
        }
        
        typeLabel.text = types
        
    }

    
    // MARK: - Navigation

//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        if segue.identifier == "ShowPokemonSegue" {
//            guard let detailVC = segue.destination as? PokemonDetailViewController else {return}
//            detailVC.pokemonController = pokemonController
//
//        }
//
//        // Pass the selected object to the new view controller.
//    }
    

}
