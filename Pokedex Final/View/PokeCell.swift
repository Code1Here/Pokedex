//
//  PokeCell.swift
//  Pokedex Final
//
//  Created by Anthony Duran on 5/17/24.
//

import UIKit

class PokeCell: UITableViewCell {
    
    @IBOutlet weak var sprite: UIImageView!
    @IBOutlet weak var setText: UILabel!
    var downloadTask: URLSessionDownloadTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        sprite.image = nil
        downloadTask?.cancel()
        downloadTask = nil
    }
    
    func configure(imageURL: URL, text: String) {
        setText.text = text
        downloadTask = sprite.loadImage(url: imageURL)
        sprite.contentMode = .scaleAspectFill
    }
    
}
