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
        return apiController.users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Pokemon Cell", for: indexPath)
        let user = apiController.users[indexPath.row]
        cell.textLabel?.text = user.name.capitalized
        guard let imageData = try? Data(contentsOf: user.image) else { fatalError() }
        cell.imageView?.image = UIImage(data: imageData)
        return cell

    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPokemon" {
            guard let pokemonDetailVC = segue.destination as? PokemonDetailViewController else {return}
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let user = apiController.users[indexPath.row]
            pokemonDetailVC.user = user
            
        }
    }


}
