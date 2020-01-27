//
//  PokedexTableViewController.swift
//  PodedexB
//
//  Created by Gerardo Hernandez on 1/26/20.
//  Copyright © 2020 Gerardo Hernandez. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {

    // MARK: -  Properties
    var pokemon: Pokemon?

    let pokedexController = PokedexController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return pokedexController.pokemons.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
//        guard indexPath.row < pokedexController.pokemons.count else {
//            return cell }
//        let index = pokedexController.pokemons[indexPath.row]
//
//        cell.textLabel?.text = index.name
        let index = pokedexController.pokemons[indexPath.row]
        let pokemon = index.form_name[indexPath.row]
        cell.textLabel?.text = pokemon.name
        
        return cell
    }
    
    // MARK: - Delete Pokemon
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokedexController.delete(pokedexController.pokemons[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .none)
        }
    }
    



    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SearchSegue" {
            if let pokedexSearchVC = segue.destination as? PokedexSearchViewController {
                pokedexSearchVC.pokedexController = pokedexController
            } else if segue.identifier == "PokeDetailSegue" {
                if let pokeDetailVC = segue.destination as? PokedexDetailViewController, let indexPath = tableView.indexPathForSelectedRow {
                    pokeDetailVC.pokedexController = pokedexController
                    pokeDetailVC.pokemon = pokedexController.pokemons[indexPath.row]
                    
                
                }
                
            }
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
   


}
