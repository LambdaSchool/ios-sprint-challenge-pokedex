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
    var pokemon: Pokemon? {
        didSet {
            DispatchQueue.main.async {
                self.titleLabel.text = self.pokemon?.name
                self.idLabel.text = String(self.pokemon!.id)
                self.typesLabel.text = self.pokemon?.types[0].type.name
                self.abilitiesLabel.text = self.pokemon?.abilities[0].ability.name
            }
            
        }
    }

    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        if pokemon != nil {
            searchBar.isHidden = true
            saveButton.isHidden = true
        }
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
    }
}

extension DetailViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        print("Search triggered")
        guard let search = searchBar.text?.lowercased(),
            !search.isEmpty else { return }
        
        print("Past the guard text: \(search)")
        pokedex.getPokemon(for: search) { result in
            if let pokemon = try? result.get() {
                self.pokemon = pokemon
                print("Set pokemon")
            }
            self.pokedex.fetchImage(at: self.pokemon!.sprites.frontDefault) { result in
                if let image = try? result.get() {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
        }
    }
}
