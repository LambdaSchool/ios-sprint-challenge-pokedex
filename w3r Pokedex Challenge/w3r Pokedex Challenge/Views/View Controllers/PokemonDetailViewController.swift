//
//  PokemonDetailViewController.swift
//  w3r Pokedex Challenge
//
//  Created by Michael Flowers on 2/1/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController, UISearchBarDelegate {
    
    var pC: PokemonController?
    var pokemon: Pokemon? {
        didSet {
            updateViews()
            print(pokemon)
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var buttonProperties: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let name = searchBar.text, !name.isEmpty else {return}
        
        pC?.fetchPokemon(with: name, completion: { (returnedPokemon, error) in
            if let error = error {
                print("Error fetching pokemon back from the method call: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                guard let pokemon = returnedPokemon else {return}
                self.pokemon = pokemon
                
            }
        })
        buttonProperties.setTitle("SAVE", for: .normal)
    }
    
    @IBAction func savePokemon(_ sender: UIButton) {
        guard let pokemon = pokemon else {return}
        pC?.savePokemon(with: pokemon)
        navigationController?.popToRootViewController(animated: true)
        
    }
    
    func updateViews(){
        guard let passedInPokemon = pokemon else {
            navigationController?.title = "Search for Pokemon"
            return
        }
        
        DispatchQueue.main.async {
            self.title = passedInPokemon.name
            self.searchBar.isHidden = true
            self.nameLabel.text = passedInPokemon.name
            self.idLabel.text = String(passedInPokemon.id)
            
            let abilities = passedInPokemon.abilities.map({$0.ability.name}).joined(separator: ",")
            self.abilitiesLabel.text = abilities
            
            let types = passedInPokemon.types.map({$0.type.name}).joined(separator: ",")
            self.typeLabel.text = types
            
            
            self.pC?.fetchSprites(with: passedInPokemon, completion: { (image, error) in
                if let error = error {
                    print("Error fetching UPDateViews image: \(error.localizedDescription)")
                }
                
                DispatchQueue.main.async {
                    self.imageView.image = image!
                }
            })
        }
    }

}
