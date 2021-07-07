//
//  PokedexTableViewController.swift
//  PokedexSprint
//
//  Created by Jorge Alvarez on 1/17/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    let apiController = ApiController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiController.pokemonArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let pokemon = apiController.pokemonArray[indexPath.row]
        cell.textLabel?.text = pokemon.name?.capitalized
        
        guard let imageData = try? Data(contentsOf: pokemon.sprites.front_default) else {return cell}
        cell.imageView?.image = UIImage(data: imageData)
        
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            print("SEARCH SEG")
            guard let detailVC = segue.destination as? DetailViewController else {return}
            detailVC.apiController = self.apiController
        }
        
        if segue.identifier == "RealDetailSegue" {
            print("REAL DETAIL SEG")
            guard let realDetailVC = segue.destination as? RealDetailViewController, let indexPath = tableView.indexPathForSelectedRow else {return}
            let pokemon = apiController.pokemonArray[indexPath.row]
            realDetailVC.apiController = self.apiController
            realDetailVC.pokemon = pokemon
        }
    }
}
