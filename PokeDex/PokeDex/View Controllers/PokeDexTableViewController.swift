//
//  PokeDexTableViewController.swift
//  PokeDex
//
//  Created by William Chen on 9/6/19.
//  Copyright © 2019 William Chen. All rights reserved.
//

import UIKit

class PokeDexTableViewController: UITableViewController {
  
    var apiController = APIController()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source



    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return apiController.pokemon.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Pokemon Cell", for: indexPath)
        let pokemon = apiController.pokemon[indexPath.row]
        cell.detailTextLabel?.text = pokemon.name.capitalized
        guard let imageData = try? Data(contentsOf: pokemon.sprites.frontDefault) else {fatalError()}
        cell.imageView?.image = UIImage(data: imageData)
        return cell
    }

    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchSegue" {
            guard let detailVC = segue.destination as? PokemonViewController else {return}
            detailVC.apiController = apiController
        }
    }

}
