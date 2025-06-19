//
//  Extensions.swift
//  Pokedex Final
//
//  Created by Anthony Duran on 4/28/24.
//

import Foundation
import UIKit

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    func lowercasingFirstLetter() -> String {
        return prefix(1).lowercased() + dropFirst()
    }
}

extension UIImageView {
  func loadImage(url: URL) -> URLSessionDownloadTask {
    let session = URLSession.shared
    let downloadTask = session.downloadTask(with: url) { [weak self] url, _, error in
      if error == nil, let url = url, let data = try? Data(contentsOf: url), let image = UIImage(data: data){
        DispatchQueue.main.async {
            if let weakSelf = self {
                weakSelf.image = image
            }
        }
      }
    }
    downloadTask.resume()
    return downloadTask
  }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat(red) / 255.0,
                  green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0,
                  alpha: alpha)
    }
    
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            alpha: alpha
        )
    }
}

func documentsDirectory() -> URL {
  let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
  return paths[0]
}

func dataFilePath() -> URL {
  return documentsDirectory().appendingPathComponent("Favorites.plist")
}

func saveFavorites() {
    let encoder = PropertyListEncoder()
    do {
        let data = try encoder.encode(favorites)
        try data.write(
            to: dataFilePath(),
            options: Data.WritingOptions.atomic)
    } catch {
        print("Error encoding set: \(error.localizedDescription)")
    }
}

func loadFavorites() {
  let path = dataFilePath()
  if let data = try? Data(contentsOf: path) {
    let decoder = PropertyListDecoder()
    do {
        favorites = try decoder.decode( Set<Int>.self, from: data)
    } catch {
        print("Error decoding set: \(error.localizedDescription)")
    }
  }
}
