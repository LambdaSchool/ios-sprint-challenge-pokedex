//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Bohdan Tkachenko on 5/16/20.
//  Copyright © 2020 Bohdan Tkachenko. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var pokemonSearchBar: UISearchBar!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var pokemonImageView: UIImageView!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var abilitiesLabel: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonaTapped(_ sender: Any) {
        
        
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
