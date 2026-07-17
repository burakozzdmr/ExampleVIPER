//
//  ProductCardView.swift
//  ExampleProject-VIPER
//
//  Created by Burak Özdemir on 17.07.2026.
//

import UIKit
import SnapKit

final class ProductCardView: UICollectionViewCell {
    static let reuseIdentifier = "ProductCardView"

    let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let shadowContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.08
        view.layer.shadowRadius = 8
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        return view
    }()

    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()

    private let imageContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()

    private let badgeView = BadgePillView()

    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.tintColor = .label
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.layer.cornerRadius = 14
        return button
    }()

    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 2
        return label
    }()

    private let priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.alignment = .firstBaseline
        return stackView
    }()

    private let oldPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .secondaryLabel
        label.isHidden = true
        return label
    }()

    private let newPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = AppColors.brandBlue
        return label
    }()

    private let ratingView = RatingView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = nil
        badgeView.isHidden = true
        oldPriceLabel.isHidden = true
        titleLabel.text = nil
        newPriceLabel.text = nil
    }

    func configure(
        title: String,
        oldPriceText: String?,
        newPriceText: String,
        ratingText: String,
        badgeText: String?,
        badgeColor: UIColor?,
        isFavorite: Bool
    ) {
        titleLabel.text = title
        newPriceLabel.text = newPriceText
        ratingView.configure(ratingText: ratingText)

        if let oldPriceText = oldPriceText {
            oldPriceLabel.attributedText = NSAttributedString(
                string: oldPriceText,
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
            oldPriceLabel.isHidden = false
        } else {
            oldPriceLabel.isHidden = true
        }

        if let badgeText = badgeText, let badgeColor = badgeColor {
            badgeView.configure(text: badgeText, backgroundColor: badgeColor)
        } else {
            badgeView.isHidden = true
        }

        let favoriteImageName = isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: favoriteImageName), for: .normal)
    }
}

// MARK: - Setup

private extension ProductCardView {
    func setupView() {
        addViews()
        configureConstraints()
    }

    func addViews() {
        contentView.addViews(shadowContainerView)
        shadowContainerView.addViews(cardView)
        cardView.addViews(imageContainerView, contentStackView)
        imageContainerView.addViews(productImageView, badgeView, favoriteButton)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(priceStackView)
        contentStackView.addArrangedSubview(ratingView)
        priceStackView.addArrangedSubview(oldPriceLabel)
        priceStackView.addArrangedSubview(newPriceLabel)
    }

    func configureConstraints() {
        shadowContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        imageContainerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(140)
        }

        productImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        badgeView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(8)
        }

        favoriteButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(8)
            make.width.height.equalTo(28)
        }

        contentStackView.snp.makeConstraints { make in
            make.top.equalTo(imageContainerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }

        ratingView.snp.makeConstraints { make in
            make.height.equalTo(16)
        }
    }
}
