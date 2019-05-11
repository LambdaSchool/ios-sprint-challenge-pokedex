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
    @IBOutlet var imageView: UIImageView!
    
    var characterController: CharacterController?
    var character: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateViews()
    }
    
    func updateViews() {
        guard let character = character else { return }
        setCharacterDetails(character: character)
    }
    
    func setCharacterDetails(character: Character?) {
        guard let character = character else { return }
        self.nameLabel.text = character.name
        self.idLabel.text = "ID: \(String(character.id))"
        var typesArray: [String] = []
        for typeDescription in character.types {
            typesArray.append(typeDescription.type.name)
        }
        self.typesLabel.text = "Types: \(typesArray.joined(separator: ", "))"
        var abilitiesArray: [String] = []
        for abilityDesription in character.abilities {
            abilitiesArray.append(abilityDesription.ability.name)
        }
        self.abilitiesLabel.text = "Abilities: \(abilitiesArray.joined(separator: ", "))"
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
