//
//  FavoritesCell.swift
//  Pokedex Final
//
//  Created by Anthony Duran on 5/23/24.
//

import UIKit

class FavoritesCell: UICollectionViewCell {
    @IBOutlet weak var mySprite: UIImageView!
    var downloadTask: URLSessionDownloadTask?
    
    func configure(imageURL: URL) {
        downloadTask = mySprite.loadImage(url: imageURL)
        mySprite.contentMode = .scaleAspectFill
    }
}

