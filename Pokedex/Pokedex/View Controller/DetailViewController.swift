//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Craig Belinfante on 1/4/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonID: UILabel!
    @IBOutlet weak var pokemonType: UILabel!
    @IBOutlet weak var pokemonAbilities: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Save Action
    @IBAction func savePokemonButtonPressed(_ sender: UIButton) {
    }
    


}

