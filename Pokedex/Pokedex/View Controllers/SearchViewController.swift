//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Waseem Idelbi on 3/22/20.
//  Copyright © 2020 WaseemID. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    //MARK: -Properties and IBOutlets-
    
    var pokemonController: PokemonController?
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var typesLabel: UILabel!
    @IBOutlet var abilitiesLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    
    //MARK: -Methods and IBActions-
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
    }
    
    func updateViews(searchTerm: String) {
       let result = pokemonController?.fetchPokemon(searchTerm: searchTerm, completion: { (error) in
        guard error == nil else {
            print("Could not fetch pokemon because: \(String(describing: error))")
            return
        }
        })
        let idNumber = result?.id as! NSNumber
        let id = idNumber.stringValue
        let types: String = (result?.types[0].type.name)!
        let abilities = result?.abilities[0].ability.name
        let data = result?.image
        let name = result?.name
        
        nameLabel.text = name
        idLabel.text = id
        typesLabel.text = types
        abilitiesLabel.text = abilities
        imageView.image = UIImage(data: data!)
    }
    
} //End of class
