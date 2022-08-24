//
//  PokemonCollectionController.swift
//  pokemon
//
//  Created by Jason Gamboa Solano on 12/8/22.
//

import UIKit

class PokemonCollectionController: UIViewController {
    
    private var pokemons: [PokemonModel] = []
    var pokemonManager = PokemonManager()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let myCellWidth = (UIScreen.main.bounds.width / 2) - 15
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        pokemonManager.delegate = self
        pokemonManager.fetchPokemons()
    }
   
}

//MARK: - Section UICollectionViewDataSource
extension PokemonCollectionController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PokemonCollectionViewCell
        
        let pokemon = pokemons[indexPath.row]
        cell.pokemonImage.downloadedFrom(link: pokemon.image)
        cell.pokemonName.text = pokemon.name
        cell.pokemonNumber.text = String(format: "#%03d", pokemon.id)
        cell.backgroundColor = UIColor(rgb: pokemon.color)
        cell.stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        pokemon.types.forEach { type in
            let typeLabel = UILabel()
            typeLabel.text = type.type.name
            cell.stackView.addArrangedSubview(typeLabel)
        }

        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension PokemonCollectionController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("\(indexPath.section) -> \(indexPath.row) \(pokemons[indexPath.row])")
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PokemonCollectionController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: myCellWidth, height: myCellWidth)
    }
    
}

//MARK: - PokemonManagerDelegate
extension PokemonCollectionController: PokemonManagerDelegate {
    func didUpdateListPokemon(_ pokemonManager: PokemonManager, pokemons: PokemonModel) {
        print("Pokemon \(pokemons.id)")
        DispatchQueue.main.async {
            self.pokemons.append(pokemons)
            self.pokemons.sort { $0.id < $1.id }
            self.collectionView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}

