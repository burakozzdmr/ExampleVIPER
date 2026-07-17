//
//  InfoGridItemView.swift
//  ExampleProject-VIPER
//
//  Created by Burak Özdemir on 17.07.2026.
//

import UIKit
import SnapKit

final class InfoGridItemView: UIView {
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()

    private let statusDotView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.stockGreen
        view.isHidden = true
        return view
    }()

    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .label
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        statusDotView.layer.cornerRadius = statusDotView.bounds.height / 2
    }

    func configure(caption: String, value: String?, showsStatusDot: Bool = false) {
        captionLabel.text = caption
        valueLabel.text = value
        statusDotView.isHidden = !showsStatusDot

        valueLabel.snp.remakeConstraints { make in
            make.top.equalTo(captionLabel.snp.bottom).offset(4)
            make.trailing.bottom.equalToSuperview()

            if showsStatusDot {
                make.leading.equalTo(statusDotView.snp.trailing).offset(6)
            } else {
                make.leading.equalToSuperview()
            }
        }
    }
}

// MARK: - Setup

private extension InfoGridItemView {
    func setupView() {
        addViews()
        configureConstraints()
    }

    func addViews() {
        addViews(captionLabel, statusDotView, valueLabel)
    }

    func configureConstraints() {
        captionLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }

        statusDotView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(valueLabel)
            make.width.height.equalTo(8)
        }

        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(captionLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview()
            make.trailing.bottom.equalToSuperview()
        }
    }
}
