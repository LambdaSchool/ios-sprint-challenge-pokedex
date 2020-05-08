//
//  PokedexTableViewController.swift
//  pokedex
//
//  Created by ronald huston jr on 5/8/20.
//  Copyright © 2020 HenryQuante. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {

    let pokemonController = PokemonController()
    
    var pokemon: Pokemon! {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }

    // MARK: - Table view data source


    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return pokemonController.pokemonArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        let pokemonFigure = pokemonController.pokemonArray[indexPath.row]
        
        cell.textLabel?.text = pokemonFigure.name
        return cell
    }

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsSegue" {
            guard let detailVC = segue.destination as? SearchDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            
            detailVC.pokemonController = pokemonController
            detailVC.pokemon = pokemonController.pokemonArray[indexPath.row]
        } else if segue.identifier == "SearchSegue" {
            if let searchVC = segue.destination as? SearchDetailViewController {
                searchVC.pokemonController = pokemonController
            }
        }
    }

}
