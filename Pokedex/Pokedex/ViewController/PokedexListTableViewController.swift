//
//  PokedexListTableViewController.swift
//  Pokedex
//
//  Created by Carolyn Lea on 8/10/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import UIKit

class PokedexListTableViewController: UITableViewController
{
    // MARK: - Properties
    
    let pokemonController = PokemonController()
    
    // MARK: - Setup
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return pokemonController.pokemons.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)

        let pokemon = pokemonController.pokemons[indexPath.row]
        cell.textLabel?.text = pokemon.name

        return cell
    }
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    // MARK: - Navigation (ToDetailView,ToSearchView)

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "ToSearchView"
        {
            guard let searchView = segue.destination as? SearchDetailViewController else {return}
            searchView.pokemonController = pokemonController
        }
        else if segue.identifier == "ToDetailView"
        {
            guard let detailView = segue.destination as? SearchDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else {return}
            detailView.pokemonController = pokemonController
            detailView.pokemon = pokemonController.pokemons[indexPath.row]
            
            
        }
    }
    

}
