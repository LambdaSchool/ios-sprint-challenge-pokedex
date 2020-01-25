//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Sal Amer on 1/24/20.
//  Copyright © 2020 Sal Amer. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    var apiController: APIController?
    
    //ibOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var idTxtField: UITextField!
    @IBOutlet weak var typesTxtField: UITextField!
    @IBOutlet weak var abilitiesTxtField: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        toggleSearchItems()
    
        // Do any additional setup after loading the view.
    }
    
   private func updateViews() {
        guard let pokemon = pokemon else {
         title = "Pokemon Search"
        searchBar.placeholder = "Search for Pokemon Character by name ir ID"
        hidePokemonItems()
        return
    }
    guard let searchBar = searchBar else { return }
    searchBar.isHidden = true
    showPokemonItems()
    
    var types: [String] = []
    var abilities: [String] = []
    for pokemonType in pokemon.types {
        types.append(pokemonType.type.name)
        
    for pokemonAbility in pokemon.abilities {
            abilities.append(pokemonAbility.ability.name)
        }
        
        nameLbl.text = pokemon.name.capitalized
        idTxtField.text = "ID: \(pokemon.id)"
        typesTxtField.text = "Types: \(pokemon.types)"
        abilitiesTxtField.text = "Abilities: \(pokemon.abilities)"
        guard let imageData = try? Data(contentsOf: pokemon.sprites.imageURL) else {fatalError()}
        image.image = UIImage(data: imageData)
        }
      }
    private func toggleSearchItems() {
        if pokemon != nil {
//            navigationItem.title = capitalize(pokemon?.name ?? "")
            searchBar.isHidden = true
            saveBtn.isHidden = true
        }
    }

    func hidePokemonItems() {
        image.isHidden = true
        nameLbl.isHidden = true
        idTxtField.isHidden = true
        typesTxtField.isHidden = true
        abilitiesTxtField.isHidden = true
    }
     func showPokemonItems() {
            image.isHidden = false
            nameLbl.isHidden = false
            idTxtField.isHidden = false
            typesTxtField.isHidden = false
            abilitiesTxtField.isHidden = false
        }
    
//    private func capitalize(_ word: String) -> String {
//          var newWord = word
//          let firstLetter = newWord.startIndex
//          let capFirst = newWord[firstLetter].uppercased()
//          newWord.remove(at: firstLetter)
//          newWord.insert(Character(capFirst), at: firstLetter)
//          return newWord
//      }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //IB Action
    
    @IBAction func savePokemonBtnWasPressed(_ sender: Any) {
        if let pokemon = pokemon,
            let apiController = apiController {
            apiController.addPokemon(pokemon: pokemon)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
extension DetailViewController: UISearchBarDelegate {
    func searchBarClicked(_ searchBar: UISearchBar) {
        guard let pokemonName = searchBar.text,
        !pokemonName.isEmpty else { return }
        
        
        apiController?.fetchAllPokemon(named: pokemonName, completion: { (result) in
            let pokemon = try? result.get()
            if let pokemon = pokemon {
                DispatchQueue.main.async {
                self.pokemon = pokemon
                self.updateViews()
            }
        }
        })
    }
}
