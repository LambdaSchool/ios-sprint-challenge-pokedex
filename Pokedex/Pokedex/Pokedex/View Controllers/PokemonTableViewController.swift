//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Waseem Idelbi on 3/22/20.
//  Copyright © 2020 WaseemID. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {

    let apiController = PokemonController()
       
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
       
       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           tableView.reloadData()
       }
       
       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return apiController.pokemonArray.count
       }
       
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
           
           let pokemonCharacter = apiController.pokemonArray[indexPath.row]
           cell.textLabel?.text = pokemonCharacter.name
           return cell
       }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.apiController.pokemonArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
       
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "DetailsSegue" {
               guard let detailVC = segue.destination as? SearchViewController,
                   let indexPath = tableView.indexPathForSelectedRow else {return}
               detailVC.apiController = apiController
               detailVC.pokemon = apiController.pokemonArray[indexPath.row]
               print("DetailViewSegue hit")
               
           }else if segue.identifier == "SearchSegue" {
               if let searchVC = segue.destination as? SearchViewController {
                   searchVC.apiController = apiController
               }
           }
       }
    
    

}
