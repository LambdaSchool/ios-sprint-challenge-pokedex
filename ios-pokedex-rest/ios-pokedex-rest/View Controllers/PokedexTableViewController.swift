//
//  PokedexTableViewController.swift
//  ios-pokedex-rest
//
//  Created by Conner on 8/10/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)

        return cell
    }
    
}
