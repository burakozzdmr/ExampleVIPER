//
//  ReviewCardView.swift
//  ExampleProject-VIPER
//
//  Created by Burak Özdemir on 17.07.2026.
//

import UIKit
import SnapKit

final class ReviewCardView: UITableViewCell {
    static let reuseIdentifier = "ReviewCardView"

    private let reviewerNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()

    private let ratingView = RatingView()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()

    private let commentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()

    private lazy var topRowStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [reviewerNameLabel, ratingView])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()

    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topRowStackView, dateLabel, commentLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with review: Review) {
        reviewerNameLabel.text = review.reviewerName
        dateLabel.text = review.date
        commentLabel.text = review.comment
        ratingView.configure(ratingText: "\(review.rating)")
    }
}

// MARK: - Setup

private extension ReviewCardView {
    func setupView() {
        selectionStyle = .none
        addViews()
        configureConstraints()
    }

    func addViews() {
        contentView.addViews(containerStackView)
    }

    func configureConstraints() {
        ratingView.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.width.equalTo(70)
        }

        containerStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
    }
}
