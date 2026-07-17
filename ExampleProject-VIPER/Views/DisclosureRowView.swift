//
//  DisclosureRowView.swift
//  ExampleProject-VIPER
//
//  Created by Burak Özdemir on 17.07.2026.
//

import UIKit
import SnapKit

final class DisclosureRowView: UIView {
    var onToggle: ((Bool) -> Void)?

    private(set) var isExpanded = false

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .label
        return label
    }()

    private let chevronImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.down"))
        imageView.tintColor = .secondaryLabel
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Actions

private extension DisclosureRowView {
    @objc func handleTap() {
        isExpanded.toggle()

        UIView.animate(withDuration: 0.25) {
            self.chevronImageView.transform = self.isExpanded
                ? CGAffineTransform(rotationAngle: .pi)
                : .identity
        }

        onToggle?(isExpanded)
    }
}

// MARK: - Setup

private extension DisclosureRowView {
    func setupView() {
        addViews()
        configureConstraints()
        configureAppearance()
    }

    func addViews() {
        addViews(titleLabel, chevronImageView)
    }

    func configureConstraints() {
        snp.makeConstraints { make in
            make.height.equalTo(48)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }

        chevronImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(14)
        }
    }

    func configureAppearance() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.cornerRadius = 12

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGestureRecognizer)
    }
}
