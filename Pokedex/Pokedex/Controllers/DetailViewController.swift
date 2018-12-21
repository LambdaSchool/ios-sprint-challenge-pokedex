//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Sameera Leola on 12/21/18.
//  Copyright © 2018 Sameera Leola. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    
    @IBOutlet weak var pokemonNameLabel: UILabel!

    @IBOutlet weak var pokemonIDText: UITextField!
    @IBOutlet weak var pokemonTypeText: UITextField!
    @IBOutlet weak var pokemonAbilitiesText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func pokemonSave(_ sender: Any) {
    }
    
    
    // MARK: - Search
    override func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
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
