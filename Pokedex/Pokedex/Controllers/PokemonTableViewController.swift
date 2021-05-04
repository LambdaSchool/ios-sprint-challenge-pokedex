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
    var pokemon: [Pokemon] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }

    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSearch" {
           if let searchVC = segue.destination as? SearchViewController  {
                searchVC.protocolDelegate = self
            }
        } else if segue.identifier == "DetailView" {
            if let searchVC = segue.destination as? SearchViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                searchVC.selectedPokemon = pokemon[indexPath.row]
                }
            }
        }

    }
}
    
    
    extension PokemonTableViewController: UITableViewDataSource {
    
        // MARK: - Table view data source
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return pokemon.count
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as?  PokemonTableViewCell else { return PokemonTableViewCell()}
            let pokemonResults = pokemon[indexPath.row]
            cell.pokemon = pokemonResults
            return cell
        }
        
    }


extension PokemonTableViewController: AddPokemonDelegate {
    func pokemonWasAdded(_ selectedPokemon: Pokemon) {
        pokemon.append(selectedPokemon)
    }
    
}

