//
//  PokeMonDetailViewController.swift
//  Pokedex
//
//  Created by Iyin Raphael on 9/21/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
//

import UIKit

class PokeMonDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func savePokemon(_ sender: Any) {
    }
    @IBOutlet weak var search: UISearchBar!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var typesLabel: UILabel!
    
    @IBOutlet weak var abilityLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
}
