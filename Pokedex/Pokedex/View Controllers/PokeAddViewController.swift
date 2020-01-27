//
//  PokeAddViewController.swift
//  Pokedex
//
//  Created by Alexander Supe on 12/8/19.
//  Copyright © 2019 Alexander Supe. All rights reserved.
//

import UIKit

class PokeAddViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    //Outlets
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    //Attributes
    var filteredPokemon: [String] = []
    var pokeContr: PokeController?
    var pokemon: Pokemon? { didSet{ updateViews() } }
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
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
        tableView.isHidden = false
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
        tableView.isHidden = true
        saveButton.isHidden = false
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedSegue" {
            guard let destination = segue.destination as? PokeDetailViewController else { return }
            destination.pokemon = self.pokemon
        }
    }
    
    // MARK: - Suggestions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection  section: Int) -> Int {
        return filteredPokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:  IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filter", for: indexPath)
        cell.textLabel?.text = filteredPokemon[indexPath.row]
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredPokemon = []
        for item in pokeContr?.pokeList?.results ?? [] {
            filteredPokemon.append(item.name)
        }
        filteredPokemon = filteredPokemon.filter { $0.lowercased().contains(searchText.lowercased()) }
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.text = filteredPokemon[indexPath.row]
        tableView.isHidden = true
        saveButton.isHidden = false
        guard let text = searchBar.text else { return }
        pokeContr?.catchPokemon(name: text){ (result) in
            DispatchQueue.main.async {
                self.pokemon = self.pokeContr?.currentPokemon
            }
        }
        
    }
    
}
