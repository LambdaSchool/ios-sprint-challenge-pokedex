//
//  PokeAddViewController.swift
//  Pokedex
//
//  Created by Alexander Supe on 12/8/19.
//  Copyright © 2019 Alexander Supe. All rights reserved.
//

import UIKit

class PokeAddViewController: UIViewController, UISearchBarDelegate {
    
    //Outlets
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var saveButton: UIButton!
    
    //Attributes
    var pokeContr: PokeController?
    var pokemon: Pokemon? { didSet{ updateViews() } }
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
    }
    
    func updateViews() {
        guard let pokemon = pokemon else { return }
        if let childVC = self.children.first as? PokeDetailViewController {
            childVC.pokemon = pokemon
        }
    }
    
    //IBActions
    @IBAction func saveAction(_ sender: Any) {
        pokeContr?.savePokemon()
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    //
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        pokeContr?.catchPokemon(name: text){ (result) in
            DispatchQueue.main.async {
                self.pokemon = self.pokeContr?.currentPokemon
            }
        }
        searchBar.resignFirstResponder()
        saveButton.isHidden = false
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedSegue" {
            guard let destination = segue.destination as? PokeDetailViewController else { return }
            destination.pokemon = self.pokemon
        }
    }
}
