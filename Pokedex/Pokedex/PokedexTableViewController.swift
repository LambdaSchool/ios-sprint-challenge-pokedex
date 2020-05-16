//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Josh Kocsis on 5/15/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    let reuseIdentifier = "PokedexCell"
    let pokedexController: PokedexController = PokedexController()
    private var pokemonNames: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pokedexController.pokemon.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! PokedexTableViewCell
        
        let pokemons = pokedexController.pokemon[indexPath.row]
        cell.pokemon = pokemons
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier  {
        case "PokemonSearchSegue":
            guard let searchVC = segue.destination as? PokemonSearchViewController else { return }
            searchVC.pokedexControllers = pokedexController
        case "PokemonDetailSegue":
            guard let detailVC = segue.destination as? PokemonDetailViewController else { return }
            if let indexPath = tableView.indexPathForSelectedRow {
                detailVC.pokemonName = pokemonNames[indexPath.row]
                detailVC.pokedexController = pokedexController
            }
        default:
            break
        }
    }
}

extension PokedexTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        searchBar.resignFirstResponder()
        
        self.pokedexController.searchForPokemonWith(searchTerm: searchTerm, completion: nil) {
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
    }
}
