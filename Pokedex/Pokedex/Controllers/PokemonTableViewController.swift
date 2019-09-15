//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Aaron on 9/14/19.
//  Copyright © 2019 AlphaGrade, INC. All rights reserved.
//

import UIKit

class PokemonTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var apiController = APIController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSearch" {
            if let searchVC = segue.destination as? SearchViewController {
                searchVC.delegate = apiController.pokemon
                searchVC.newPokemon = apiController.myPokemon
            }
        }
    }
}
    
    
    extension PokemonTableViewController: UITableViewDataSource {
    
        // MARK: - Table view data source
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return apiController.pokemon.count
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokeCell", for: indexPath) as?  PokemonTableViewCell else { return PokemonTableViewCell()}
            let pokemonResults = apiController.pokemon[indexPath.row]
            cell.pokemon = pokemonResults
            return cell
        }
        
    }


 

