//
//  DetailViewController.swift
//  pokedex
//
//  Created by Joshua Sharp on 9/6/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var delegate: pokemonDelegate?
    var pokemonController: PokemonController?
    var pokemon : Pokemon?{
        didSet{
            updateViews()
        }
    }
    var searching : Bool = false
    
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var ImageV: UIImageView!
    @IBOutlet weak var idL: UILabel!
    @IBOutlet weak var typesL: UILabel!
    @IBOutlet weak var abilitiesL: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var saveButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if searching { searchBar.isHidden = false}
        searchBar.delegate = self
        updateViews()
    }
    
    func updateViews() {
        if self.isViewLoaded {
            searchBar.isHidden = !searching
            if let pokemon = pokemon {
                nameL.text = pokemon.name
                ImageV.downloaded(from: pokemon.sprites.front_default)
                idL.text = "\(pokemon.id)"
                typesL.text = pokemon.getTypesString
                abilitiesL.text = pokemon.getAbilitiesString
            } else {
                searchBar.becomeFirstResponder()
            }
        }
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        guard let pokemonController = pokemonController,
        let pokemon = pokemon else { return }
        
        pokemonController.savedPokemon.append(pokemon)
        saveButton.isEnabled = false
        //self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
}

extension DetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        pokemonController?.findPokemon(with: searchText, completion: { (error) in
            if let error = error {
                NSLog("Search failed: \(error)")
            } else {
                DispatchQueue.main.async {
                    self.pokemon =  self.pokemonController?.foundPokemon
                    
                    self.saveButton.isHidden = false
                }
            }
        })
        
    }
}
