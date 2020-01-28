//
//  PokedexDetailViewController.swift
//  Pokedex
//
//  Created by Gerardo Hernandez on 1/27/20.
//  Copyright © 2020 Gerardo Hernandez. All rights reserved.
//

import UIKit

class PokedexDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
        var pokedexController = PokedexController()
        
        var pokemon: Pokemon? {
            didSet {
                updateViews()
            }
        }
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            updateViews()

            // Do any additional setup after loading the view.
        }
            func updateViews() {
            if let pokemon = pokemon {
                updateDetailView(pokemon)
            } else {
            clearDetailView()
            }
        }
        
            private func updateDetailView(_ pokemon: Pokemon) {
            pokedexController.fetchImage(at: pokemon.sprites.front_shiny, completion: { (result) in
                do {
                    let pokeImage = try result.get()
                    self.updateSprite(with: pokeImage)
                } catch {
                    self.imageView.image = nil
                    
                }
            })
                DispatchQueue.main.async {
                    
                self.nameLabel.text = "\(pokemon.name.capitalized)"
                self.idLabel.text = "\(pokemon.id)"
                self.typesLabel.text = pokemon.types[0].type.name
                self.abilitiesLabel.text = pokemon.abilities[0].ability.name
            }
        }

        
        private func clearDetailView() {
            DispatchQueue.main.async {
                self.nameLabel.text = ""
                self.abilitiesLabel.text = ""
                self.idLabel.text = ""
                self.imageView = nil
                self.typesLabel.text = ""
            }
            
        }
            
        
        private func updateSprite(with image: UIImage)  {
            DispatchQueue.main.async {
                self.imageView.image = image
            }
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
