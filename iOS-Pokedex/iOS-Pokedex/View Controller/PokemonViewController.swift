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
        updateViews()
    }
    
    //Variables
    var delegate: PokemonTableViewController?
    var pokemonController: PokemonController?
    var displayedPokemon: PokemonTesting?
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
    
    
    //Functions
    func updateViews() {
        guard let displayedPokemon = displayedPokemon else { return }
        
        //Update: name, id, type, abilities, sprite
        nameLabel.text = displayedPokemon.name
        idLabel.text = String(displayedPokemon.id)
        typeLabel.text = displayedPokemon.types[0].type.name
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        guard let pokemonController = pokemonController else { return }
        pokemonController.getPokemon(name: text) {
            DispatchQueue.main.async {
                self.displayedPokemon = self.pokemonController?.pokemon
                self.updateViews()
            }
        }
    }

    /*
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
    }*/
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
