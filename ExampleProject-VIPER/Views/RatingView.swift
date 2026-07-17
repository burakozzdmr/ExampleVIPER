//
//  RatingView.swift
//  ExampleProject-VIPER
//
//  Created by Burak Özdemir on 17.07.2026.
//

import UIKit
import SnapKit

final class RatingView: UIView {
    private let starImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
        imageView.tintColor = AppColors.ratingOrange
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .secondaryLabel
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(ratingText: String) {
        ratingLabel.text = ratingText
    }
}

// MARK: - Setup

private extension RatingView {
    func setupView() {
        addViews()
        configureConstraints()
    }

    func addViews() {
        addViews(starImageView, ratingLabel)
    }

    func configureConstraints() {
        starImageView.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
            make.width.height.equalTo(14)
        }

        ratingLabel.snp.makeConstraints { make in
            make.leading.equalTo(starImageView.snp.trailing).offset(4)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}
