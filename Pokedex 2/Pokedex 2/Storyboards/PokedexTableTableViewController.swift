//
//  PokedexTableTableViewController.swift
//  Pokedex 2
//
//  Created by Bhawnish Kumar on 3/14/20.
//  Copyright © 2020 Bhawnish Kumar. All rights reserved.
//

import UIKit

class PokedexTableTableViewController: UITableViewController {
    var pokemon: Pokemon? {
        didSet {
            tableView.reloadData()
        }
    }
let pokemonController = PokemonController()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           tableView.reloadData()
       }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokemonList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        let addPokemon = pokemonController.pokemonList[indexPath.row]
       
        cell.textLabel?.text = addPokemon.name
        // Configure the cell...

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
             pokemonController.pokemonList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pokemonViewSegue" {
                  guard let pokemonSearchVC = segue.destination as? PokemonSearchViewController else { return }
                  guard let indexPath = tableView.indexPathForSelectedRow else { return }
                  guard indexPath.row < pokemonController.pokemonList.count else { return }
                  
                  let pokemon = self.pokemonController.pokemonList[indexPath.row]
                  pokemonSearchVC.pokemonController = self.pokemonController
                  pokemonSearchVC.pokemon = pokemon
                  pokemonSearchVC.navigationItem.title = pokemon.name.capitalized
                  
              } else if segue.identifier == "searchPokemonSegue" {
                  guard let pokemonSearchVC = segue.destination as? PokemonSearchViewController else { return }
                  
                  pokemonSearchVC.pokemonController = self.pokemonController
              }
    }
    

}
