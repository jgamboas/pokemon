//
//  ListPokemonData.swift
//  pokemon
//
//  Created by Jason Gamboa Solano on 17/8/22.
//

import Foundation

struct ListPokemonData: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [ResultDetail]
}

struct ResultDetail: Codable {
    let name: String
    let url: String
    var id: Int {
        let numberPokemon = url.split(separator: "/")
        return Int(String(numberPokemon[numberPokemon.count - 1])) ?? 0
    }
    var image: String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png"
    }
}
