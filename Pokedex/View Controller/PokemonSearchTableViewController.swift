//
//  PokemonSearchTableViewController.swift
//  Pokedex
//
//  Created by alfredo on 1/26/20.
//  Copyright © 2020 Alfredo. All rights reserved.
//

import UIKit

class PokemonSearchTableViewController: UITableViewController {

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - IBOutlets
    
    @IBOutlet weak var searchBar: UISearchBar!

    // MARK: - Properties
    
    var pokedexController: PokedexController?
    var matchedPokemon: [String] = []
    var delegate: SavePokemon?
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchedPokemon.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MatchedPokemonCell", for: indexPath) as? MatchedPokemonTableViewCell else { return UITableViewCell() }
        let row = indexPath.row
        let pokemonName = matchedPokemon[row]
        
        cell.matchedPokemonLabel.text = pokemonName
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "PokemonDetailSegue" else { return }
        guard let pokemonDetailVC = segue.destination as? PokemonDetailViewController else { return }
        guard let cell = sender as? MatchedPokemonTableViewCell else { return }
        guard let pokemonName = cell.matchedPokemonLabel.text else { return }
        guard let pokemon = pokedexController!.pokedex[pokemonName] else { return }
        
        pokemonDetailVC.pokedexController = pokedexController
        pokemonDetailVC.pokemon = pokemon
        pokemonDetailVC.delegate = delegate
    }

}
extension PokemonSearchTableViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchBarText = searchBar.text else { return }
        guard !searchBarText.isEmpty else { return }
        var pokemon = (pokedexController?.performSearch(searchBarText))!
        
        matchedPokemon = pokemon.sorted()
        tableView.reloadData()
    }
}
