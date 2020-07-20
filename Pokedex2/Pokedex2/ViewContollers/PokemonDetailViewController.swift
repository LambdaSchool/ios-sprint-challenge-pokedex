//
//  PokemonDetailViewController.swift
//  Pokedex2
//
//  Created by Clean Mac on 7/19/20.
//  Copyright © 2020 LambdaStudent. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
