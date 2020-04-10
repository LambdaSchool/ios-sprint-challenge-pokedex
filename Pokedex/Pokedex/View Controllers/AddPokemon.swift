//
//  AddPokemon.swift
//  Pokedex
//
//  Created by Shawn James on 4/10/20.
//  Copyright © 2020 Shawn James. All rights reserved.
//

import UIKit

class AddPokemon: UIViewController {
    
    // MARK: - Selected user pokemon
    
    var selectedUserPokemon: Pokemon?
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idTextView: UITextView!
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var abilitiesTextView: UITextView!
    @IBOutlet weak var addButton: UIButton!
    
    // MARK: - Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Add button action
    
    @IBAction func addPokemon(_ sender: Any) {
        if selectedUserPokemon != nil {
            navigationController?.popViewController(animated: true)
            // above: add button should actually be invisible an non-functional in this case
            return
        } else {
            UserPokemon.addPokemonToUserAddedPokemon(selectedUserPokemon)
            navigationController?.popViewController(animated: true)
        }
    }
    
    
    
}
