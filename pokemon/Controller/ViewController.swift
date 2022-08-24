//
//  ViewController.swift
//  pokemon
//
//  Created by Jason Gamboa Solano on 12/8/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "PokemonCollectionView", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "navigationPokemon")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}

