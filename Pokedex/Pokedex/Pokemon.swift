//
//  Pokemon.swift
//  Pokedex
//
//  Created by Keri Levesque on 2/14/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//

import Foundation


 struct Pokemon: Decodable {
     var name: String?
     var id: Int?
     var abilities: [Ability]
     var types: [Type]
     var sprites: Sprite?
     
     struct Ability: Decodable {
         var ability: AbilityName
     }

     struct AbilityName: Decodable {
         var name: String
     }
     
     struct Type: Decodable {
         var type: TypeName
     }

     struct TypeName: Decodable {
         var name: String
     }
     
     struct Sprite: Decodable {
         
         enum CodingKeys: String, CodingKey {
             case frontDefault = "front_default"
         }

         var frontDefault: String
     }
     
 }
