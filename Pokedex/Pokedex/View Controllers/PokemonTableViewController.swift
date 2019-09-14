//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by John Kouris on 9/14/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    var pokemons = [Pokemon]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)

        let pokemon = pokemons[indexPath.row]
        cell.textLabel?.text = pokemon.name.capitalized

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            let destinationVC = segue.destination as? PokemonSearchViewController
            destinationVC?.viewType = .search
            destinationVC?.delegate = self
        } else if segue.identifier == "ShowDetailSegue" {
            let destinationVC = segue.destination as? PokemonSearchViewController
            destinationVC?.viewType = .detail
            
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            destinationVC?.pokemon = pokemons[indexPath.row]
        }
    }
    

}

extension PokemonTableViewController: SearchPokemonDetailsDelegate {
    func save(pokemon: Pokemon) {
        pokemons.append(pokemon)
        tableView.reloadData()
    }
}
