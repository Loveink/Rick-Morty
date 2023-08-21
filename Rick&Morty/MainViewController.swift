//
//  MainViewController.swift
//  Rick&Morty
//
//  Created by Александра Савчук on 18.08.2023.
//

import UIKit
import SwiftUI

class MainViewController: UIViewController, CharactersCollectionViewDelegate {

    private var collectionView: CharactersCollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        subviews()
        setupConstraints()
        setupNavigationBar()
        fetchCharacters()
    }

    private func subviews() {
        collectionView = CharactersCollectionView(frame: .zero, characters: [])
        view.addSubview(collectionView)
      collectionView.collectionDelegate = self
    }

  func didSelectCharacter(_ character: Result) {
      let characterDetailView = CharacterDetailView(character: character, navigateBack: {
          self.navigationController?.popViewController(animated: true)
      })
      let hostingController = UIHostingController(rootView: characterDetailView)
      navigationController?.pushViewController(hostingController, animated: true)
  }

    func fetchCharacters() {
        let apiService = APIService()
        apiService.fetchCharacters { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.collectionView.characters = response.results
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print("Error fetching characters:", error)
            }
        }
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .white
        let titleLabel = UILabel()
        titleLabel.text = "Characters"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.sizeToFit()
        let titleBarButton = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItem = titleBarButton
    }

    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
