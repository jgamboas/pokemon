//
//  PokemonData.swift
//  pokemon
//
//  Created by Jason Gamboa Solano on 17/8/22.
//

import Foundation

struct PokemonData: Codable {
    let id: Int
    let name: String
    var image: String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png"
    }
    let types: [TypesPokemon]
    let abilities: [Abilities]
}


struct TypesPokemon: Codable {
    let slot: Int
    let type: TypePokemon
}

struct TypePokemon: Codable {
    let name: String
    let url: String
}

struct Abilities: Codable {
    let ability: Ability
}

struct Ability: Codable {
    let name: String
    let url: String
}
