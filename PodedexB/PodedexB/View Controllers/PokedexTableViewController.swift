//
//  PokedexTableViewController.swift
//  PodedexB
//
//  Created by Gerardo Hernandez on 1/26/20.
//  Copyright © 2020 Gerardo Hernandez. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {

    
    private var pokemonName: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    let pokedexController = PokedexController()
    
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
        return pokemonName.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        cell.textLabel?.text = pokemonName[indexPath.row]
        

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokedexController.delete(pokedexController.pokemons[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .none)
        }
    }
    



    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            if let pokedexVC = segue.destination as? PokedexDetailViewController {
               
                pokedexVC.pokedexController = pokedexController
               
              
                
            }
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
   

}
