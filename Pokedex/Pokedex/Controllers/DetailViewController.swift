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
//        toggleSearchItems()
    
        // Do any additional setup after loading the view.
    }
    
   private func updateViews() {
        guard let pokemonDetail = pokemon else {
         title = "Pokemon Search"
//        searchBar.placeholder = "Search for Pokemon Character by name"
        hidePokemonItems()
        return
    }
    guard let searchBar = searchBar else { return }
    searchBar.isHidden = true
    showPokemonItems()
    
    var types: [String] = []
//    var abilities: [String] = []
    for pokemonType in pokemonDetail.types {
        types.append(pokemonType.type.name)
        
//
//    for pokemonAbility in pokemon.abilities {
//            abilities.append(pokemonAbility.ability.name)
//        }
//
        title = pokemonDetail.name
        nameLbl.text = pokemonDetail.name
        idTxtField.text = "ID: \(pokemonDetail.id)"
        typesTxtField.text = "Types: \(pokemonDetail.types)"
        abilitiesTxtField.text = "Abilities: \(pokemonDetail.abilities)"
        apiController?.fetchImage(from: pokemonDetail.sprites.imageURL, completion: { (pokemonImage) in
            DispatchQueue.main.async {
                self.image.image = pokemonImage
            }
        })
//        guard let imageData = try? Data(contentsOf: pokemonDetail.sprites.imageURL) else {fatalError()}
//        image.image = UIImage(data: imageData)
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

    private func capitalize(_ word: String) -> String {
          var newWord = word
          let firstLetter = newWord.startIndex
          let capFirst = newWord[firstLetter].uppercased()
          newWord.remove(at: firstLetter)
          newWord.insert(Character(capFirst), at: firstLetter)
          return newWord
      }

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
        guard let searchName = searchBar.text else { return }
//        !searchName.isEmpty else { return }
        
        
        apiController?.fetchAllPokemon(pokemonName: searchName, completion: { (pokemonDetail) in
            guard let pokemon = try? pokemonDetail.get() else { return }
                DispatchQueue.main.async {
                self.pokemon = pokemon
                self.updateViews()
            }
        })
        guard let pokemonImageURL = pokemon?.sprites.imageURL else { return }
        apiController?.fetchImage(from: pokemonImageURL, completion: { (pokemonImage) in
            DispatchQueue.main.async {
                self.image.image = pokemonImage
            }
        })
    }
}
