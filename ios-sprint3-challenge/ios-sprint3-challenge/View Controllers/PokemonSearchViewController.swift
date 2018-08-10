//
//  PokemonSearchViewController.swift
//  ios-sprint3-challenge
//
//  Created by De MicheliStefano on 10.08.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    // MARK: - Methods
    
    @IBAction func save(_ sender: Any) {
    }
    
    private func updateViews() {
        
    }
    
    
    // MARK: - Properties

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var identifierTextLabel: UILabel!
    @IBOutlet weak var typeTextLabel: UILabel!
    @IBOutlet weak var abilitiesTextLabel: UILabel!
    @IBOutlet weak var buttonTextLabel: UIButton!
}
