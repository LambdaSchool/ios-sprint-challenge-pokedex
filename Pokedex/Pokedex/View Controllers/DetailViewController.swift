//
//  DetailViewController.swift
//  Pokedex
//
//  Created by morse on 5/10/19.
//  Copyright © 2019 morse. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var typesLabel: UILabel!
    @IBOutlet var abilitiesLabel: UILabel!
    
    var character: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateViews()
    }
    
    func updateViews() {
        guard let character = character else { return }
        nameLabel.text = character.name
        idLabel.text = "ID: \(String(character.id))"
//        typesLabel.text = String(character.types)
//        abilitiesLabel.text = String(character.abilities)
    }

}
