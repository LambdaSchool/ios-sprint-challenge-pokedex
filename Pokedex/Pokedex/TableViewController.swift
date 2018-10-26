//
//  TableViewController.swift
//  Pokedex
//
//  Created by Jerrick Warren on 10/26/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let reuseIdentifier = "pokemoncell"
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        return cell
    }
}

