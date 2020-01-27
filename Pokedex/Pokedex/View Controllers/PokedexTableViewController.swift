//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Joshua Rutkowski on 1/26/20.
//  Copyright © 2020 Josh Rutkowski. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    
    //MARK: - Properties
    let pokedexController = PokedexController()

    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedController.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "SortBy")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sortPokemon()
    }

    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokedexController.pokemons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        cell.textLabel?.text = pokedexController.pokemons[indexPath.row].name.capitalized
        return cell
    }
    
    // Delete functionality
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            pokedexController.delete(pokedexController.pokemons[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddPokemonSegue" {
            if let addVC = segue.destination as? PokedexDetailViewController {
                addVC.pokedexController = pokedexController
            }
        } else if segue.identifier == "PokemonDetailSegue" {
            if let detailVC = segue.destination as? PokedexDetailViewController, let indexPath = tableView.indexPathForSelectedRow {
                detailVC.pokedexController = pokedexController
                detailVC.pokemon = pokedexController.pokemons[indexPath.row]
            }
        }
    }
    
    // MARK: - Sorting
    
    private func sortPokemon() {
        pokedexController.sortPokemon()
        tableView.reloadData()
    }
    
    
    @IBAction func pokemonSort(_ sender: Any) {
        switch UserDefaults.standard.integer(forKey: "SortBy") {
        case 0:
            UserDefaults.standard.set(1, forKey: "SortBy")
        default:
            UserDefaults.standard.set(0, forKey: "SortBy")
        }
        sortPokemon()
    }
    

    
}
