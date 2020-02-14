//
//  PokemonDetailViewController.swift
//  PokeDex
//
//  Created by Enrique Gongora on 2/14/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    
    //MARK: - Variables
    var pokemonController: PokemonController?
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //MARK: - Functions
    func updateViews() {
        guard isViewLoaded, let pokemonDetail = pokemon else {
            title = "Pokemon Search"
            return
        }
        guard let pokemonName = pokemonNameLabel.text else { return }
        
        title = pokemonDetail.name.capitalized
        pokemonNameLabel.text = pokemonName
        idLabel.text = "ID: \(pokemonDetail.id)"
        typeLabel.text = "Type: \(pokemonDetail.types)"
        abilityLabel.text = "Ability: \(pokemonDetail.abilities)"
        
        pokemonController?.fetchImage(with: pokemonDetail.sprites.defaultImageURL, completion: { (result) in
            do {
                let pokemonImage = try result.get()
                self.updateImage(with: pokemonImage)
            } catch {
                self.imageView.image = nil
            }
        })
    }
    
    func updateImage(with image: UIImage) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
}
