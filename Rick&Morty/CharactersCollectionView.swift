//
//  CharactersCollectionView.swift
//  Rick&Morty
//
//  Created by Александра Савчук on 18.08.2023.
//

import UIKit

class CharactersCollectionView: UICollectionView {

  var characters: [Result] = []

  init(frame: CGRect, characters: [Result]) {
    self.characters = characters
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    super.init(frame: frame, collectionViewLayout: layout)

    configureCollection()

  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configureCollection() {
    dataSource = self
    delegate = self
    showsHorizontalScrollIndicator = false
    backgroundColor = .clear
    register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.identifier)
  }
}

extension CharactersCollectionView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return characters.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier, for: indexPath) as! CharacterCell

    if indexPath.row < characters.count {
      let character = characters[indexPath.row]
      cell.configureCell(character)
    }
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.frame.width / 2.1
    let height = width + 50

    return CGSize(width: width, height: height)
  }
}
