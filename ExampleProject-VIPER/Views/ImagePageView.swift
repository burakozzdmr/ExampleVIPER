//
//  ImagePageView.swift
//  ExampleProject-VIPER
//
//  Created by Burak Özdemir on 17.07.2026.
//

import UIKit
import SnapKit

final class ImagePageView: UICollectionViewCell {
    static let reuseIdentifier = "ImagePageView"

    let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray6
        return imageView
    }()

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
    }
}

// MARK: - Setup

private extension ImagePageView {
    func setupView() {
        addViews()
        configureConstraints()
    }

    func addViews() {
        contentView.addViews(productImageView)
    }

    func configureConstraints() {
        productImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
