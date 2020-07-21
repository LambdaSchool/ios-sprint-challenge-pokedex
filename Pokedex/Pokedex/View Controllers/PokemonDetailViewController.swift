//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Sammy Alvarado on 7/20/20.
//  Copyright © 2020 Sammy Alvarado. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!


    var apiController: APIController?
    var pokemonNames: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDetail()
        // Do any additional setup after loading the view.
    }



    func fetchDetail() {
        guard let apiController = apiController,
            let pokemonName = pokemonNames else { return }

        apiController.fetchPokemon(for: pokemonName) { (result) in
            switch result {
            case .success(let pokemon):
                DispatchQueue.main.async {
                    self.updateViews(with: pokemon)
                }
                apiController.fetchPokemonImage(at: pokemon.sprites.absoluteString) { (result) in
                    if let image = try? result.get() {
                        DispatchQueue.main.async {
                            self.imageLabel.image = image
                        }
                    }
                }
            case .failure(let error):
                print("Error Fetching pokemon Detials \(error)")
            }
        }
    }

    func updateViews(with pokemon: Pokemon) {
        guard isViewLoaded else { return }

        title = pokemon.name.capitalized
        guard let pokemonImageData = try? Data(contentsOf: pokemon.sprites) else {return}
        imageLabel.image = UIImage(data: pokemonImageData)
        nameLabel.text = pokemon.name.capitalized
        idLabel.text = "ID: \(String(pokemon.id))"

        var types = " "
        let typeArray = pokemon.types
        for type in typeArray {
            types.append(type.capitalized)
        }
        typesLabel.text = "Types: \(types)"

        var abilities = " "
        let abilityArray = pokemon.abilities
        for ability in abilityArray {
            abilities.append(ability.capitalized)
        }
        abilitiesLabel.text = "Abilities: \(abilities)"

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

/*

   func getDetails() {
         guard let apiController = apiController,
             let animalName = animalName else { return }

         apiController.fetchDetails(for: animalName) { (result) in
             switch result {
             case .success(let animal):
                 DispatchQueue.main.async {
                     self.updateViews(with: animal)
                 }
                 apiController.fetchImage(at: animal.imageURL) { (result) in
                     if let image = try? result.get() {
                         DispatchQueue.main.async {
                             self.animalImageView.image = image
                         }
                     }
                 }
             case .failure(let error):
                 print("Error fetching animal detials \(error)")
             }
         }
     }

     func updateViews(with animals: Animal) {
         title = animals.name
         descriptionLabel.text = animals.description
         coordinatesLabel.text = "lat: \(animals.latitude), long: \(animals.longitude)"
         let df = DateFormatter()
         df.dateStyle = .short
         df.timeStyle = .short
         timeSeenLabel.text = df.string(from: animals.timeSeen)
     }
 }

 */
