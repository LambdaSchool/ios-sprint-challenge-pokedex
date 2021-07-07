//
//  ViewController.swift
//  Pokedex
//
//  Created by Simon Elhoej Steinmejer on 10/08/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController
{
    let pokemonController = PokemonController()
    let cellId = "pokemonCell"

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        setupNavBar()
    }
    
    private func setupNavBar()
    {
        title = "Pokedex"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(goToSearch))
    }

    @objc private func goToSearch()
    {
        let pokemonViewController = PokemonViewController()
        pokemonViewController.pokemonController = pokemonController
        navigationController?.pushViewController(pokemonViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return pokemonController.pokemons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let pokemon = pokemonController.pokemons[indexPath.row]
        
        cell.textLabel?.text = pokemon.name
        
        if let urlString = pokemon.sprites?.front_default
        {
            cell.imageView?.loadImageUrlString(urlString)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let pokemon = pokemonController.pokemons[indexPath.row]
        let pokemonViewController = PokemonViewController()
        pokemonViewController.pokemonController = pokemonController
        pokemonViewController.pokemon = pokemon
        navigationController?.pushViewController(pokemonViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: deleteHandlerFunction)
        
        return [deleteAction]
    }
    
    private func deleteHandlerFunction(action: UITableViewRowAction, indexPath: IndexPath)
    {
        pokemonController.deletePokemon(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    
}








