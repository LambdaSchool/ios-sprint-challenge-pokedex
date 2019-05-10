//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Lisa Sampson on 5/10/19.
//  Copyright © 2019 Lisa M Sampson. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    let pokemonController = PokemonController()

    // MARK: - View Loading Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokedex.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)

        cell.textLabel?.text = pokemonController.pokedex[indexPath.row].name.capitalized
//        cell.imageView?.image = UIImage(contentsOfFile: pokemonController.pokedex[indexPath.row].sprites.frontDefault)
        
        let spriteURL = URL(string: pokemonController.pokedex[indexPath.row].sprites.frontDefault)!
        cell.imageView!.load(url: spriteURL)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let pokemon = pokemonController.pokedex[indexPath.row]
            pokemonController.delete(pokemon: pokemon)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            let searchVC = segue.destination as! PokemonSearchViewController
            searchVC.pokemonController = pokemonController
        }
        if segue.identifier == "DetailSegue" {
            let detailVC = segue.destination as! PokemonDetailViewController
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            detailVC.pokemon = pokemonController.pokedex[indexPath.row]
        }
    }
}
