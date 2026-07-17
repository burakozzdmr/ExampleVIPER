//
//  PageIndicatorView.swift
//  ExampleProject-VIPER
//
//  Created by Burak Özdemir on 17.07.2026.
//

import UIKit
import SnapKit

final class PageIndicatorView: UIView {
    private let numberOfDots: Int
    private var dotViews: [UIView] = []

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.alignment = .center
        return stackView
    }()

    init(numberOfDots: Int = 3) {
        self.numberOfDots = numberOfDots
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setActiveDot(at index: Int) {
        for (dotIndex, dotView) in dotViews.enumerated() {
            let isActive = dotIndex == index
            dotView.backgroundColor = isActive ? AppColors.brandBlue : .systemGray4
            dotView.snp.updateConstraints { make in
                make.width.equalTo(isActive ? 16 : 6)
            }
        }
    }
}

// MARK: - Setup

private extension PageIndicatorView {
    func setupView() {
        addViews()
        configureConstraints()
        buildDots()
    }

    func addViews() {
        addViews(stackView)
    }

    func configureConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func buildDots() {
        dotViews = (0..<numberOfDots).map { index in
            let dotView = UIView()
            dotView.backgroundColor = index == 0 ? AppColors.brandBlue : .systemGray4
            dotView.layer.cornerRadius = 3
            dotView.snp.makeConstraints { make in
                make.height.equalTo(6)
                make.width.equalTo(index == 0 ? 16 : 6)
            }
            return dotView
        }

        dotViews.forEach { stackView.addArrangedSubview($0) }
    }
}
