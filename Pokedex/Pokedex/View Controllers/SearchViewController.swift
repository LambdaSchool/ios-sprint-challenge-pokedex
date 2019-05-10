//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Alex on 5/10/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon? {
        didSet{
            updateViews()
        }
    }
    
    // MARK: - Outlets
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var idLbl: UILabel!
    @IBOutlet var typesLbl: UILabel!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var abilitiesLbl: UILabel!
    
    // MARK: - Actions
    @IBAction func saveBtnPressed(_ sender: UIButton) {
        guard let pokemon = pokemon else { return }
        pokemonController?.createPokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        guard let pokemon = pokemon else {
            idLbl.isHidden = true
            typesLbl.isHidden = true
            abilitiesLbl.isHidden = true
            return
        }
        // unhide hidden labels
        idLbl.isHidden = false
        typesLbl.isHidden = false
        abilitiesLbl.isHidden = false
        // set labels
        nameLbl?.text = pokemon.name
        idLbl?.text = String(pokemon.id)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        pokemonController?.performSearch(searchTerm: searchTerm, completion: { (pokemon, error) in
            if let error = error {
                print("There was an error \(error)")
                return
            }
            self.pokemon = pokemon
        })
        self.searchBar.endEditing(true)
        updateViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateViews()
    }

    
}
