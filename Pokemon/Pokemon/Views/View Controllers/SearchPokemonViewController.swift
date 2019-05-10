//
//  SearchPokemonViewController.swift
//  Pokemon
//
//  Created by Michael Flowers on 5/10/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class SearchPokemonViewController: UIViewController, UISearchBarDelegate {
    
    var pc: PokemonController?
    var pokemon: Pokemon? {
        didSet {
            print("we passed the pokemon to the searchPokemonvc")
            updateViews()
        }
    }

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var saveButtonProperties: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        updateViews()
    }
    
    @IBAction func savePokemon(_ sender: UIButton) {
    }
    
    func updateViews(){
        //make sure you have a pokemon, and that the view is loaded
        guard let passedInPokemon = pokemon, isViewLoaded else {
            title = "Search for Pokemon"
            return }
        title = passedInPokemon.name
        idLabel.text = String(passedInPokemon.id)
        
        let types = passedInPokemon.types.map { $0.type.name}.joined(separator: ",")
        typesLabel.text = types
        
        let abilties = passedInPokemon.abilities.map { $0.ability.name}.joined(separator: ",")
        abilitiesLabel.text = abilties
        saveButtonProperties.isHidden = true
        searchBar.isHidden = true
        
//        imageView.image = UIImage(named: passedInPokemon.sprities.imageURL)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let name = searchBar.text, !name.isEmpty else { return }
        
        pc?.fetchPokemon(with: name, completion: { (returnedPokemon, error) in
            if let error = error {
                print("Error fetching pokemon: \(error.localizedDescription)")
                return
            }
            
            if let pokemon = returnedPokemon {
                DispatchQueue.main.async {
                    //because the pokemon we empty when came to ths scene, we have to assign its value to the returned pokemon so that it will trigger the upateViews function
                    self.pokemon = pokemon
                }
                //now fetch image because you have a pokemon that was returned
                self.pc?.fetchSprite(with: pokemon, completion: { (image, error) in
                    if let error = error {
                        print("WE cant get the mage: \(error.localizedDescription)")
                        return
                    }
                    if let image = image {
                        DispatchQueue.main.async {
                            self.imageView.image = image
                        }
                    }
                })
            }
           
        })
        
    }
}
