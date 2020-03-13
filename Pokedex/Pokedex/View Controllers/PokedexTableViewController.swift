//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Lambda_School_Loaner_259 on 3/13/20.
//  Copyright © 2020 DeVitoC. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    // MARK: - Properties
    let pokeController = PokeController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokeController.pokemons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokeCell", for: indexPath)
        let pokemon = pokeController.pokemons[indexPath.row]
        
        cell.textLabel?.text = pokemon.name
        

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchPokeSegue" {
            guard let searchVC = segue.destination as? SearchViewController else { return }
            searchVC.delegate = self
            
        } else if segue.identifier == "PokeDetailSegue" {
            guard let pokeDetailVC = segue.destination as? PokeDetailsViewController else { return }
            pokeDetailVC.pokeController = pokeController
            pokeDetailVC.pokemon
        }
    }

}

extension PokedexTableViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let pokemon = searchBar.text,
            !pokemon.isEmpty {
            pokeController.fetchPokemon(pokemon: pokemon) { result in
                
            }
            
        }
        navigationController?.popToRootViewController(animated: true)
    }
}
