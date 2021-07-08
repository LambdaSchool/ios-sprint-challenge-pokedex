//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Ngozi Ojukwu on 8/17/18.
//  Copyright © 2018 iyin. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return pokemonController.pokemons.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = pokemonController.pokemons[indexPath.row].name
        return cell
    }


   


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokemonController.delete(index:indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
          
        }    
    }



    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addDetail"{
            guard let detailVC = segue.destination as? PokemonSearchViewController else {return}
            detailVC.pokemonController =  pokemonController
  
        }
        
        if segue.identifier == "showDetail"{
            let detailVC = segue.destination as! PokedexDetailViewController
            detailVC.pokemonController = pokemonController
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            detailVC.pokemon = pokemonController.pokemons[indexPath.row]
        }
    }

    var pokemonController = PokemonController()
}
