//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Julian A. Fordyce on 1/1/19.
//  Copyright © 2019 Glas Labs. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController, UISearchBarDelegate {
    
    var pokemon: Pokemon?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var typesLabel: UILabel!
    
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        updateViews()
        pokemonNameLabel.text = ""
        idLabel.text = ""
        abilitiesLabel.text = ""
        typesLabel.text = ""
        saveButton.isHidden = true 
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func updateViews() {
        DispatchQueue.main.async {
            guard let pokemon = self.pokemon else { return }
            guard let url = URL(string: pokemon.sprites.frontDefault),
                let imageData = try? Data(contentsOf: url) else { return }
            self.navigationItem.title = pokemon.name
            self.idLabel.text = "ID: \(pokemon.id)"
            let types: [String] = pokemon.types.map{$0.type.name}
            self.typesLabel.text = "Types: \(types.joined(separator: ", "))"
            let abilities: [String] = pokemon.abiliities.map{$0.ability.name}
            self.abilitiesLabel.text = "Abilities: \(abilities.joined(separator: ", "))"
            self.imageView.image = UIImage(data: imageData)
        }
    }
}
