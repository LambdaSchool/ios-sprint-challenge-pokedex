//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Karen Rodriguez on 3/13/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Properties
    
    var pokedex: Pokedex!
    var pokemon: Pokemon?

    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if pokemon != nil {
            searchBar.isHidden = true
            saveButton.isHidden = true
        }
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
    }
}

extension DetailViewController: UISearchBarDelegate {
    
}
