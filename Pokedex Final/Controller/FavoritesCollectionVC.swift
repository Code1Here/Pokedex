//
//  FavoritesCollectionVC.swift
//  Pokedex Final
//
//  Created by Anthony Duran on 4/29/24.
//

import UIKit

private let reuseIdentifier = "Cell"

class FavoritesCollectionVC: UICollectionViewController {
    
    var favArray: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favArray = Array(favorites)
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        configurelayout()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavsCell", for: indexPath) as! FavoritesCell
        cell.backgroundColor = .blue
        
        let i = indexPath.row
        let spritesURL = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/\(favArray[i]).png")!
        cell.configure(imageURL: spritesURL)
        
        return cell
    }
    
    func configurelayout() {
        let layout = UICollectionViewFlowLayout()
        let padding: CGFloat = 10
        let totalPadding: CGFloat = padding * 4
        let numberOfItemsPerRow: CGFloat = 3
        
        let itemWidth = (view.frame.width - totalPadding) / numberOfItemsPerRow
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        
        collectionView.collectionViewLayout = layout
    }

    // Trying to reload data when Favorites tab is tapped
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //        collectionView?.reloadData()
    //    }
}
