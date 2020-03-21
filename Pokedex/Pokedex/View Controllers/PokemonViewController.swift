//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Chad Parker on 3/20/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    var apiController = APIController() // TODO: pass this in

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func updateViews() {
        guard let pokemon = pokemon else { return }
        nameLabel.text = pokemon.name.capitalized
        getImage()
        idLabel.text = "\(pokemon.id)"
        //typesLabel.text = String(describing: pokemon.types)
        //abilitiesLabel.text = String(describing: pokemon.abilities)
    }
    
    private func getImage() {
        guard let pokemon = pokemon else { return }
        self.apiController.fetchImage(at: pokemon.sprites.front_default) { result in
            guard let image = try? result.get() else { return }
            
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
}
