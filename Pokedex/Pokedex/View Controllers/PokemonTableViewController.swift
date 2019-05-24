//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Jordan Davis on 5/24/19.
//  Copyright © 2019 Jordan Davis. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchPokemonViewController.updateViews() //I called this here im order to be able to retrieve my image when the save pkmn is clicked on
        tableView.reloadData()
    }
    
    @IBAction func search(_ sender: Any) {
    }
    
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokeCell", for: indexPath)
        
        let pokemon = pokemonController.pokemons[indexPath.row]
        
        cell.textLabel?.text = pokemon.name.capitalized
        
        //convert the string into a URL
        //guard let url = url(pokemon.sprites.imageURL) else {}
        
        //convert the url into data
        //convert the data into UIImage
        cell.imageView?.image = UIImage(named: pokemon.sprites.imageURL)
        return cell
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let pokemonToDelete = pokemonController.pokemons[indexPath.row]
            pokemonController.delete(pokemon: pokemonToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            let destinationVC = segue.destination as! SearchPokemonViewController
            destinationVC.pokemonController = pokemonController
        }
        
        if segue.identifier == "PokeCellSegue" {
            guard let destinationVC = segue.destination as? SearchPokemonViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
            let pokemonToPass = pokemonController.pokemons[indexPath.row]
            destinationVC.pokemon = pokemonToPass
            destinationVC.pokemonController = pokemonController
        }
    }
    
    //MARK: - Properties
    
    let pokemonController = PokemonController()
    let searchPokemonViewController = SearchPokemonViewController()
    
    
} 
