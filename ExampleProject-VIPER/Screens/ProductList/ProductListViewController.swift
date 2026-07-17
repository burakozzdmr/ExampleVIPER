//
//  ProductListViewController.swift
//  ExampleProject-VIPER
//
//  Created by Burak Özdemir on 16.07.2026.
//

import UIKit
import SnapKit

final class ProductListViewController: UIViewController {

    // MARK: - Properties

    private let presenter: ProductListPresenterProtocol

    private let products: [Product] = []

    // MARK: - UI Components

    private let hamburgerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        button.tintColor = .label
        return button
    }()

    private let logoLabel: UILabel = {
        let label = UILabel()
        label.text = "TrendStore"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = AppColors.brandBlue
        return label
    }()

    private let cartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "cart"), for: .normal)
        button.tintColor = .label
        return button
    }()

    private let cartBadgeView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.badgeRed
        return view
    }()

    private let headerBarView = UIView()

    private let sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tüm Ürünler"
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textColor = .label
        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
        collectionView.backgroundColor = .clear
        collectionView.register(ProductCardView.self, forCellWithReuseIdentifier: ProductCardView.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Inits

    init(presenter: ProductListPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup

private extension ProductListViewController {
    func setupView() {
        view.backgroundColor = .systemBackground
        addViews()
        configureConstraints()
    }

    func addViews() {
        view.addViews(headerBarView, sectionTitleLabel, collectionView)
        headerBarView.addViews(hamburgerButton, logoLabel, cartButton, cartBadgeView)
    }

    func configureConstraints() {
        headerBarView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(52)
        }

        hamburgerButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }

        logoLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        cartButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }

        cartBadgeView.snp.makeConstraints { make in
            make.top.trailing.equalTo(cartButton)
            make.width.height.equalTo(8)
        }

        sectionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(headerBarView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(sectionTitleLabel.snp.bottom).offset(12)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    func makeLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(280)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
        group.interItemSpacing = .fixed(12)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)

        return UICollectionViewCompositionalLayout(section: section)
    }
}

// MARK: - ProductListViewProtocol Methods

extension ProductListViewController: ProductListViewProtocol {

}

// MARK: - UICollectionViewDataSource

extension ProductListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: ProductCardView.reuseIdentifier, for: indexPath)
    }
}

// MARK: - UICollectionViewDelegate

extension ProductListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
