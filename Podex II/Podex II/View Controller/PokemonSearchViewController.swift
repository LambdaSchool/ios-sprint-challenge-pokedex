//
//  PokemonSearchViewController.swift
//  Podex II
//
//  Created by Ivan Caldwell on 12/14/18.
//  Copyright © 2018 Ivan Caldwell. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {
    // Variables and Constants
    var pokemon: Pokemon?
    
    // Outlets and Actions
    @IBOutlet weak var pokemonAbilityLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    // Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
