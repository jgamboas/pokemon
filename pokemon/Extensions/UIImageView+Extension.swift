//
//  UIImageView+Extension.swift
//  pokemon
//
//  Created by Jason Gamboa Solano on 17/8/22.
//

import UIKit

extension UIImageView {
    func downloadedFrom(link:String) {
        guard let url = URL(string: link) else {return}
        downloadedFrom(url: url)
    }
    
    func downloadedFrom(url:URL)  {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse,
                                httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
}
