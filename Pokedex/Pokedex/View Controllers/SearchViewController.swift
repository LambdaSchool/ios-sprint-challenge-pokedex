//
//  SearchViewController.swift
//  Pokedex
//
//  Created by morse on 5/10/19.
//  Copyright © 2019 morse. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var typesLabel: UILabel!
    @IBOutlet var abilitiesLabel: UILabel!
    @IBOutlet var saveButton: UIButton!
    
    var characterController: CharacterController?
    var character: Character?

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameLabel.text = ""
        idLabel.text = ""
        typesLabel.text = ""
        abilitiesLabel.text = ""
        saveButton.tintColor = .white
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text?.lowercased() else { return }


        characterController?.searchForCharacters(with: searchTerm, completion: { result in
            if let character = try? result.get() {
                self.character = character
                DispatchQueue.main.async {
                    self.nameLabel.text = character.name
                    self.idLabel.text = "ID: \(String(character.id))"
//                    self.typesLabel.text = character.types.
//                    self.abilitiesLabel.text = String(character.abilities)
                    self.saveButton.tintColor = UIColor(displayP3Red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
                }
            }
        })
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let character = character {
            characterController?.characters.append(character)
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
    
}
