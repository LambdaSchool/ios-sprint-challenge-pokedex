//
//  SearchViewController.swift
//  DianteSprint3PokeMon
//
//  Created by Diante Lewis-Jolley on 2/1/19.
//  Copyright © 2019 Diante Lewis-Jolley. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    let pokemonController = PokemonController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func updateViews() {
        guard let result = result else {
            nameLabel.text = ""
            idLabel.text = ""
            abilitiesLabel.text = ""
            typesLabel.text = ""
            idFrontLabel.isHidden = true
            typesFrontLabel.isHidden = true
            abilitiesFrontLabel.isHidden = true
            buttonLabel.isHidden = true
            return
        }
        nameLabel.text = result.name.capitalized
        idLabel.text = "\(result.id)"
        idFrontLabel.isHidden = false
        typesFrontLabel.isHidden = false
        abilitiesFrontLabel.isHidden = false
        buttonLabel.isHidden = false

        let abilityName = result.abilities.map { $0.ability.name }
        let typeName = result.types.map { $0.type.name }

        abilitiesLabel.text = abilityName.first
        typesLabel.text = typeName.first

        pokemonController.fetchImageFor(pokemon: result, completion: { (data) in
            guard let data = data else { return }

            let image = UIImage(data: data)
            self.pokemonImage.image = image
        })



    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        pokemonController.fetchPokemon(with: searchTerm, completion: { (result, error) in
            if let error = error {
                print(error)
                return
            }

            DispatchQueue.main.async {
                self.result = result
                self.updateViews()
            }
        })

    }


    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let result = result else { return }
        pokemonController.savePokemon(pokemon: result)
        navigationController?.popViewController(animated: true)
    }



    var result: Pokemon? {
        didSet {
            updateViews()
        }
    }


    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var idFrontLabel: UILabel!
    @IBOutlet weak var typesFrontLabel: UILabel!
    @IBOutlet weak var abilitiesFrontLabel: UILabel!
    @IBOutlet weak var buttonLabel: UIButton!


}
