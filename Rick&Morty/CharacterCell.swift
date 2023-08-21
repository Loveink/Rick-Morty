//
//  CharacterCell.swift
//  Rick&Morty
//
//  Created by Александра Савчук on 18.08.2023.
//

import UIKit

class CharacterCell: UICollectionViewCell {
  
  static let identifier = "CharacterCell"
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.layer.cornerRadius = 10
    imageView.clipsToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    label.textColor = .white
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupSubviews()
    setupConstraints()
    contentView.backgroundColor = UIColor(red: 0.15, green: 0.16, blue: 0.22, alpha: 1)
    contentView.layer.cornerRadius = 10
    contentView.clipsToBounds = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupSubviews() {
    contentView.addSubview(imageView)
    contentView.addSubview(titleLabel)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
      imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
      
      titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
    ])
  }
  
  func configureCell(_ data: Result) {
    titleLabel.text = data.name
    
    if let imageURL = URL(string: data.image) {
      URLSession.shared.dataTask(with: imageURL) { [weak self] data, response, error in
        if let error = error {
          print("Error loading image: \(error)")
          return
        }
        
        if let data = data, let image = UIImage(data: data) {
          DispatchQueue.main.async {
            self?.imageView.image = image
          }
        }
      }.resume()
    }
  }
}
