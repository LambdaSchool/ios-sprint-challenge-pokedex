//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Hayden Hastings on 5/17/19.
//  Copyright © 2019 Hayden Hastings. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokemon.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokedexCell", for: indexPath)
        
        let pokemon = pokemonController.pokemon[indexPath.row]
        
        cell.textLabel?.text = pokemon.name
        
        guard let url = URL(string: pokemon.sprites.frontDefault),
            let image = try? Data(contentsOf: url) else { return cell }
        cell.imageView?.image = UIImage(data: image)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokemonController.pokemon.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetailVC" {
            if let pokemonVC = segue.destination as? PokedexDetailViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    pokemonVC.pokemon = pokemonController.pokemon[indexPath.row]
                }
                pokemonVC.pokemonController = pokemonController
            }
        } else if segue.identifier == "SearchSegue" {
            if let pokemonSVC = segue.destination as? SearchPokemonViewController {
                pokemonSVC.pokemonController = pokemonController
            }
        }
    }
    
    let pokemonController = PokemonController()
}
