//
//  PokeListTableViewController.swift
//  PokedexApp
//
//  Created by Nelson Gonzalez on 1/24/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class PokeListTableViewController: UITableViewController {
    
    var pokemonController: PokemonController = PokemonController()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       // return PokemonController.shared.pokemons.count
        return pokemonController.pokemons.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeCell", for: indexPath)

     //   let pokemons = PokemonController.shared.pokemons[indexPath.row]
        let pokemons = pokemonController.pokemons[indexPath.row]
        
        cell.textLabel?.text = pokemons.name
        guard let imageUrl = URL(string: pokemons.sprites.frontDefault), let imageData = try? Data(contentsOf: imageUrl) else {return cell}
        cell.imageView?.image = UIImage(data: imageData)

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
         //   let pokemon = PokemonController.shared.pokemons[indexPath.row]
             let pokemon = pokemonController.pokemons[indexPath.row]
            
         //   PokemonController.shared.deletePokemon(pokemon: pokemon)
             pokemonController.deletePokemon(pokemon: pokemon)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "fromCell" {
            let destinationVC = segue.destination as? PokeSearchViewController
            destinationVC?.pokemonController = pokemonController
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
       //     let pokemon = PokemonController.shared.pokemons[indexPath.row]
             let pokemon = pokemonController.pokemons[indexPath.row]
            destinationVC?.pokemon = pokemon
            
            
        } else if segue.identifier == "fromSearch" {
            let destinationVC = segue.destination as? PokeSearchViewController
            destinationVC?.pokemonController = pokemonController
           // destinationVC?.pokemon = pokemon
            
            
        }
    }
    

}
