//
//  PokeDetailsViewController.swift
//  Pokedex
//
//  Created by Lambda_School_Loaner_259 on 3/13/20.
//  Copyright © 2020 DeVitoC. All rights reserved.
//

import UIKit

class PokeDetailsViewController: UIViewController {
    
    // MARK: - Properties
    let pokeController: PokeController?
    let pokemon: Pokemon
    var delegate: UISearchBarDelegate
    
    
    // MARK: - IBOutlets
    @IBOutlet var pokeImageView: UIImageView!
    @IBOutlet var pokeIDLabel: UILabel!
    @IBOutlet var pokeTypesLabel: UILabel!
    @IBOutlet var pokeAbilitiesLabel: UILabel!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var searchBar: UISearchBar!
    
    
    // MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
    }
    
    

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
