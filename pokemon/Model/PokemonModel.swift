//
//  PokemonModel.swift
//  pokemon
//
//  Created by Jason Gamboa Solano on 17/8/22.
//

import Foundation
import UIKit

struct PokemonModel: Codable {
    let name: String
    let id: Int
    let image: String
    let color: Int
    let abilities: [Abilities]
    let types: [TypesPokemon]
}
