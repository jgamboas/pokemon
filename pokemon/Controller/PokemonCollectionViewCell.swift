//
//  PokemonCollectionViewCell.swift
//  pokemon
//
//  Created by Jason Gamboa Solano on 12/8/22.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonNumber: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        // Initialization code
    }
    
    private func setupUI() {
        backgroundColor = UIColor(rgb: 0xFFEDDDD1)
        layer.cornerRadius = 15.0
        pokemonName.font = UIFont.boldSystemFont(ofSize: 20)
        pokemonImage.layer.cornerRadius = 35
    }
    
}
