//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Dahna on 4/10/20.
//  Copyright © 2020 Dahna Buenrostro. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    
    let pokemonController = PokemonController()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokemonList.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        let pokemon = pokemonController.pokemonList[indexPath.row]
        cell.textLabel?.text = pokemon.name.capitalized
        return cell
    }
  
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokemonController.deletePokemon(index: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.reloadData()
        }
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonSearchShowSegue" {
            let destinationVC = segue.destination as! PokemonSearchViewController
            destinationVC.pokemonController = pokemonController
            
        }
        
        if segue.identifier == "ShowPokemonSegue" {
            guard let cell = sender as? UITableViewCell else { return }
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            let pokemon = self.pokemonController.pokemonList[indexPath.row]
            guard let destinationVC = segue.destination as? PokemonSearchViewController else { return }
            destinationVC.pokemonController = self.pokemonController
            destinationVC.displayPokemon = pokemon
            print(pokemonController.pokemonList)
        }
    }
    

}

//extension PokedexTableViewController: PokeDelegate {
//    func currentPokemon(_ pokemon: Pokemon) {
//        self.currentPokemon = pokemon
//    }
//
//
//}
