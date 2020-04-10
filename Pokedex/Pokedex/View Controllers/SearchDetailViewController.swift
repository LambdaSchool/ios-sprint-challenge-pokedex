//
//  SearchDetailViewController.swift
//  Pokedex
//
//  Created by Chris Dobek on 4/10/20.
//  Copyright © 2020 Chris Dobek. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
    }
    

}
