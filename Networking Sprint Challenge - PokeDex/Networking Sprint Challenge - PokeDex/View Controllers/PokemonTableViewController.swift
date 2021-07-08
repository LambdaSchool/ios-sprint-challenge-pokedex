//
//  PokemonTableViewController.swift
//  Networking Sprint Challenge - PokeDex
//
//  Created by Vijay Das on 2/1/19.
//  Copyright © 2019 Vijay Das. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    

    let pokemonController = PokemonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemonArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = pokemonController.pokemonArray[indexPath.row].name.capitalized
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokemonController.removePokemon(index: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "search" {
            guard let searchVC = segue.destination as? SearchViewController else { return }
            searchVC.pokemonController = pokemonController
            

        }
        if segue.identifier == "detail" {
            guard let detailVC = segue.destination as? DetailViewController,
            let index = tableView.indexPathForSelectedRow else { return }
            detailVC.pokemonController = pokemonController
            detailVC.pokemon = pokemonController.pokemonArray[index.row]
            
            
            
        }
    }

    }
    
    
        



