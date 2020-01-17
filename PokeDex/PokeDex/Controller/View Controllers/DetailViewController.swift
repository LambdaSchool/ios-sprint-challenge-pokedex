//
//  DetailViewController.swift
//  PokeDex
//
//  Created by Kenny on 1/17/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        print("tapped")
    }
    //pokemon var with didset to
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        setupViews()
    }

    func setupViews() {
        //check for pokemon. if not found, disable UI, hide elements
    }
    
    func updateUI() {
        //if there's a pokemon, fill in the details
    }
}

extension DetailViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

