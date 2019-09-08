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
        title = pokemon.name
        
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
