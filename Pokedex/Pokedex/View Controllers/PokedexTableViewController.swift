//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Cody Morley on 4/10/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {

    var pokemonController = PokemonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokedex.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? PokedexTableViewCell else { return UITableViewCell()}
        let pokemon = pokemonController.pokedex[indexPath.row]
        cell.pokemon = pokemon
        return cell
    }
    

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            guard let destinationVC = segue.destination as? PokemonSearchViewController else { print("nosegue")
                return }
            destinationVC.pokemonController = pokemonController
        }
        
        if segue.identifier == "DetailSegue" {
            guard let destinationVC = segue.destination as? PokemonDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            destinationVC.pokemon = pokemonController.pokedex[indexPath.row]
        }
    }
   

}
