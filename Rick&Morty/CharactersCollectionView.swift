//
//  CharactersCollectionView.swift
//  Rick&Morty
//
//  Created by Александра Савчук on 18.08.2023.
//

import UIKit

class CharactersCollectionView: UICollectionView {

  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.minimumInteritemSpacing = 10
    flowLayout.minimumLineSpacing = 10
    flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 40) / 2, height: 200)
    super.init(frame: frame, collectionViewLayout: flowLayout)
    dataSource = self
    delegate = self
    register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.reuseIdentifier)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

extension CharactersCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.reuseIdentifier, for: indexPath) as! CharacterCell
        let title = "Character \(indexPath.item)"
        let image = UIImage(named: "character\(indexPath.item)")
        cell.configure(with: title, image: image ?? UIImage())

        return cell
    }
}
