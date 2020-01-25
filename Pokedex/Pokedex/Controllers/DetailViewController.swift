//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Sal Amer on 1/24/20.
//  Copyright © 2020 Sal Amer. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    //ibOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var typesLbl: UILabel!
    @IBOutlet weak var abilitiesLbl: UILabel!
    @IBOutlet weak var saveBtn: UIButton!


 
//
//        // Do any additional setup after loading the view.
//    }
//
//   private func updateViews() {
////    guard isViewLoaded else { return }
//        guard let pokemonObject = pokemon else {
//         title = "Pokemon Search"
////        searchBar.placeholder = "Search for Pokemon Character by name"
////          print("Labels not updated")
//
//        return
//    }
//
//    print("\(pokemonObject.name) set in detail view")
//    title = pokemonObject.name.capitalized
//    nameLbl.text = pokemon?.name
//    idLbl.text = "ID: \(pokemonObject.id)"
//
////    guard let searchBar = searchBar else { return }

//
//    var types: [String] = []
//    for typeInfo in pokemonObject.types {
//        types.append(typeInfo.type.name)
//        }
//        typesLbl.text = "Pokemon Types: \(types.joined(separator: ", "))"
//        abilitiesLbl.text = "Abilities: \(pokemonObject.abilities[0].ability.name)"
////
////    for pokemonAbility in pokemon.abilities {
////            abilities.append(pokemonAbility.ability.name)
////        }
//////
////        title = pokemonDetail.name
////        nameLbl.text = pokemonDetail.name
////        idLbl.text = "ID: \(pokemonDetail.id)"
////        typesLbl.text = "Types: \(pokemonDetail.types)"
////        abilitiesLbl.text = "Abilities: \(pokemonDetail.abilities)"
//        apiController?.fetchImage(from: pokemonObject.sprites.imageUrl, completion: { (pokemonImage) in
//            DispatchQueue.main.async {
//                self.image.image = pokemonImage
//            }
//        })
////        guard let imageData = try? Data(contentsOf: pokemonDetail.sprites.imageURL) else {fatalError()}
////        image.image = UIImage(data: imageData)
//        }
//      }
//



    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    var apiContoller: APIController? {
        didSet {
            updateViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.becomeFirstResponder()
        updateViews()
        searchBar.delegate = self
        toggleSearchItems()
    }
    
        private func toggleSearchItems() {
            if pokemon != nil {
                navigationItem.title = capitalize(pokemon?.name ?? "")
                searchBar.isHidden = true
                saveBtn.isHidden = true
            }
        }
    
            func hidePokemonItems() {
                image.isHidden = true
                nameLbl.isHidden = true
                idLbl.isHidden = true
                typesLbl.isHidden = true
                abilitiesLbl.isHidden = true
            }
             func showPokemonItems() {
                    image.isHidden = false
                    nameLbl.isHidden = false
                    idLbl.isHidden = false
                    typesLbl.isHidden = false
                    abilitiesLbl.isHidden = false
                }
        
            private func capitalize(_ word: String) -> String {
                  var newWord = word
                  let firstLetter = newWord.startIndex
                  let capFirst = newWord[firstLetter].uppercased()
                  newWord.remove(at: firstLetter)
                  newWord.insert(Character(capFirst), at: firstLetter)
                  return newWord
              }
         
    
 
    func updateViews() {
        guard isViewLoaded else { return }
        guard let pokemonObject = pokemon else {
            title = "Pokemon Search"
            print("Labels not updated")
            hidePokemonItems()
            return }
        
        print("\(pokemonObject.name) set in detail view")
        title = pokemonObject.name.capitalized
        nameLbl.text = pokemon?.name
        idLbl.text = "ID: \(pokemonObject.id)"
        
        searchBar.isHidden = true
        showPokemonItems()
        
        var types: [String] = []
        for typeInfo in pokemonObject.types {
            types.append(typeInfo.type.name)
        }
        
        typesLbl.text = "Pokemon Type: \(types.joined(separator: ", "))"
        abilitiesLbl.text = "Abilities: \(pokemonObject.abilities[0].ability.name)"
        
        apiContoller?.fetchImage(from: pokemonObject.sprites.imageUrl, completion: { pokemonImage in
            DispatchQueue.main.async {
                self.image.image = pokemonImage
            }
        })
    }
    @IBAction func savePokemonBtnWasPressed(_ sender: Any) {
         if let pokemon = pokemon,
             let apiController = apiContoller {
             apiController.addPokemon(pokemon: pokemon)
             self.navigationController?.popViewController(animated: true)
         }
     }
}
extension DetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        apiContoller?.fetchAllPokemon(pokemonName: searchTerm, completion: { pokemonObject in
            guard let pokemon = try? pokemonObject.get() else { return }
            
            DispatchQueue.main.async {
                self.pokemon = pokemon
            }
        })
        guard let pokemonImgUrl = pokemon?.sprites.imageUrl else { return }
        apiContoller?.fetchImage(from: pokemonImgUrl, completion: { pokemonImage in
            DispatchQueue.main.async {
                self.image.image = pokemonImage
            }
        })
    }
}
 
