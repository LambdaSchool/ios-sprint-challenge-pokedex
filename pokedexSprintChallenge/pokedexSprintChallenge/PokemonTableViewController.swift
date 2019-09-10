//
//  PokemonTableViewController.swift
//  pokedexSprintChallenge
//
//  Created by admin on 9/6/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    var pokemonController = PokemonController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokemon.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        let pokemon = pokemonController.pokemon[indexPath.row]
        
        cell.textLabel?.text = pokemon.name
        
        guard let url = URL(string: pokemon.image.frontDefault),
            let images = try? Data(contentsOf: url) else { return cell }
        cell.imageView?.image = UIImage(data: images)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokemonController.pokemon.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pokedexDetailViewSegue" {
            if let pokemonVC = segue.destination as? PokemonDetailViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                pokemonVC.pokemon = pokemonController.pokemon[indexPath.row]
            }
            
        } else if segue.identifier == "" {
            if let pokemonVC = segue.destination as? SearchPokemonViewController {
                pokemonVC.pokemonController = pokemonController
            }
        }
    }
    
}

}
