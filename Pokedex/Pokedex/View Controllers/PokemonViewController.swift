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
            if isViewLoaded { updateViews() }
        }
    }
    var apiController: APIController?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    private func updateViews() {
        guard let pokemon = pokemon else { return }
        
        navigationItem.title = pokemon.name.capitalized
        nameLabel.text = pokemon.name.capitalized
        setImage()
        idLabel.text = "\(pokemon.id)"
        typesLabel.text = pokemon.types.map { $0.type.name.capitalized }.joined(separator: ", ")
        abilitiesLabel.text = pokemon.abilities.map { $0.ability.name.capitalized }.joined(separator: ", ")
    }
    
    private func setImage() {
        guard let pokemon = pokemon else { return }
        
        self.apiController?.fetchImage(at: pokemon.sprites.front_default) { result in
            guard let image = try? result.get() else { return }
            
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
}
