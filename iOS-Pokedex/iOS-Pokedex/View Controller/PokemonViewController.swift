//
//  PokemonViewController.swift
//  iOS-Pokedex
//
//  Created by Cameron Collins on 4/10/20.
//  Copyright © 2020 Cameron Collins. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController, UISearchBarDelegate {

    //Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.autocapitalizationType = .none
        if let displayedPokemon = displayedPokemon {
            nameLabel.text = displayedPokemon.name
            searchBar.text = displayedPokemon.name
        }
    
    }
    
    //Variables
    var delegate: PokemonTableViewController?
    var pokemonController: PokemonController?
    var displayedPokemon: Pokemon1?
    var selectedRow: Int?

    
    //Actions
    @IBAction func buttonPressed(_ sender: UIButton) {
        if selectedRow == nil {
            guard let pokemon = displayedPokemon else { return }
            pokemonController?.pokemonAdded.append(pokemon)
            delegate?.updateViews()
            navigationController?.popViewController(animated: true)
        }
        
        if let selectedRow = selectedRow {
            guard let pokemon = displayedPokemon else { return }
            pokemonController?.pokemonAdded[selectedRow] = pokemon
            delegate?.updateViews()
            navigationController?.popViewController(animated: true)
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let pokemonController = pokemonController else { return }
        guard let pokemon = pokemonController.pokemon else { return }
        
        //Search for contact
        for i in pokemon.results {
            if searchText.contains(i.name) {
                nameLabel.text = i.name
                displayedPokemon = Pokemon1(name: i.name, url: i.url)
                break
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
