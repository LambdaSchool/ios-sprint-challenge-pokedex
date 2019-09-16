//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Dillon P on 9/14/19.
//  Copyright © 2019 Lambda iOSPT2. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    var pokemonInPokedex: [Pokemon] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonInPokedex.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        let pokemon = pokemonInPokedex[indexPath.row]
        if let title = cell.textLabel {
            title.text = pokemon.name.capitalized
        }
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchPokemonShowSegue" {
            guard let searchPokemonVC = segue.destination as? PokemonSearchViewController else { return }
            searchPokemonVC.delegate = self
        } else if segue.identifier == "ShowPokemonDetailSegue" {
            guard let pokemonDetailVC = segue.destination as? PokemonSearchViewController else { return }
            if let indexPath = tableView.indexPathForSelectedRow {
                pokemonDetailVC.pokemon = pokemonInPokedex[indexPath.row]
                pokemonDetailVC.elementsVisible = false
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            pokemonInPokedex.remove(at: indexPath.row)
        }
        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        tableView.reloadData()
    }
    

}

extension PokemonTableViewController: UpdatePokedex {
    func saveToPokedex(with pokemon: Pokemon) {
        pokemonInPokedex.append(pokemon)
        tableView.reloadData()
    }
    
}
