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
    @IBOutlet var imageView: UIImageView!
    
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
                    self.setCharacterDetails(character: character)

                    self.saveButton.tintColor = UIColor(displayP3Red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
                }
            } else {
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Sorry", message: "That is not a Pokemon.", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Search Again", style: .default, handler: nil)
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true, completion: {
                        searchBar.text = ""
                    })
                }
            }
        })
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let characterController = characterController else { return }
        if let character = character {
            
            if !characterController.characters.contains(character) {
                characterController.characters.append(character)
            }
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func setCharacterDetails(character: Character?) {
        guard let character = character else { return }
        self.nameLabel.text = character.name
        self.idLabel.text = "ID: \(String(character.id))"
        var typesArray: [String] = []
        for typeDescription in character.types {
            typesArray.append(typeDescription.type.name)
        }
        self.typesLabel.text = "Types:\n\n\(typesArray.joined(separator: ", "))\n\n"
        var abilitiesArray: [String] = []
        for abilityDesription in character.abilities {
            abilitiesArray.append(abilityDesription.ability.name)
        }
        self.abilitiesLabel.text = "Abilities:\n\n\(abilitiesArray.joined(separator: ", "))\n"
        let spriteURL = character.sprites.front_default
        characterController?.fetchImage(at: spriteURL, completion: { result in
            DispatchQueue.main.async {
                if let image = try? result.get() {
                    self.imageView.image = image
                }
            }
        })
        
        
    }
    
}
