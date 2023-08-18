//
//  MainViewController.swift
//  Rick&Morty
//
//  Created by Александра Савчук on 18.08.2023.
//

import UIKit

class MainViewController: UIViewController {

    private let collectionView = CharactersCollectionView()

    private lazy var scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        subviews()
        setupConstraints()
        setupNavigationBar()
    }

    private func subviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(collectionView)
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
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            collectionView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            collectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
}
