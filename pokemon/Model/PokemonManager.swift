//
//  PokemonManager.swift
//  pokemon
//
//  Created by Jason Gamboa Solano on 17/8/22.
//

import Foundation
import CoreLocation

protocol PokemonManagerDelegate {
    func didUpdateListPokemon(_ pokemonManager: PokemonManager, pokemons: PokemonModel)
    func didFailWithError(error: Error)
}

class PokemonManager {
    let weatherURL = "https://pokeapi.co/api/v2/pokemon"
    var pokemonResult = [PokemonModel]()
    var delegate: PokemonManagerDelegate?
    
    func fetchPokemons() {
        let urlString = "\(weatherURL)"
        performRequestList(with: urlString)
    }
    
    private func fetchPokemon(name: String) {
        let urlString = "\(weatherURL)\(name)"
        performRequest(with: urlString)
    }
    
    func performRequestList(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    self.loadPokemonList(safeData)
                }
            }
            task.resume()
        }
        print(pokemonResult.count)
    }
    
    func loadPokemonList(_ pokemonData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ListPokemonData.self, from: pokemonData)
            
            decodedData.results.forEach { pokemon in
                self.performRequest(with: pokemon.url)
            }
            
            //delegate?.didUpdateListPokemon(self, pokemons: pokemonResult)
        } catch {
            delegate?.didFailWithError(error: error)
        }
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let pokemonModel = self.parseJSON(safeData) {
                        //self.pokemonResult.append(pokemonModel)
                        self.delegate?.didUpdateListPokemon(self, pokemons: pokemonModel)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ pokemonData: Data) -> PokemonModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(PokemonData.self, from: pokemonData)
            let name = decodedData.name
            let id = decodedData.id
            let image = decodedData.image
            let color = getColorByType(decodedData.types[0].type.name)
            let abilities = decodedData.abilities
            let types = decodedData.types
            let pokemonModel = PokemonModel(name: name, id: id, image: image, color: color, abilities: abilities, types: types)
            return pokemonModel
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    private func getColorByType(_ firstType: String) -> Int{
        var result: Int
        switch firstType.uppercased() {
        case "NORMAL":
            result =  0xFFEDDDD1
        case "FIRE":
            result =  0xFFFFCC97
        case "WATER":
            result =  0xFF6891f0
        case "GRASS":
            result =  0xFFC2FFC2
        case "ELECTRIC":
            result =  0xFFFFF596
        case "ICE":
            result =  0xFFD9FFFF
        case "FIGHTING":
            result =  0xFFFF9B97
        case "POISON":
            result =  0xFFE5B1FF
        case "GROUND":
            result =  0xFFFFF5BA
        case "FLYING":
            result =  0xFFD4D4FF
        case "PSYCHIC":
            result =  0xFFFFACD7
        case "BUG":
            result =  0xFFF6FF91
        case "ROCK":
            result =  0xFFFFF7A4
        case "GHOST":
            result =  0xFFD6CBFF
        case "DRAGON":
            result =  0xFFBA9DFF
        case "DARK":
            result =  0xFFACA6FF
        case "STEEL":
            result =  0xFFF0F4FF
        case "FAIRY":
            result =  0xFFFFCEFC
        default:
            result =  0xFFFFFF
        }
        
        return result

    }
    
    
    
}
