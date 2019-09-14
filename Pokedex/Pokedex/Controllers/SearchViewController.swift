//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Aaron on 9/14/19.
//  Copyright © 2019 AlphaGrade, INC. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var delegate: [Pokemon]?
    var newPokemon: Pokemon?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func savePokemonTapped(_ sender: Any) {
        if let newPokemon = newPokemon {
            delegate?.append(newPokemon)
        }
        dismiss(animated: true)
    }
    

}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
}
