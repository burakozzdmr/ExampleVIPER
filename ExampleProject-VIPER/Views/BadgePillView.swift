//
//  BadgePillView.swift
//  ExampleProject-VIPER
//
//  Created by Burak Özdemir on 17.07.2026.
//

import UIKit

final class BadgePillView: UILabel {
    private let textInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            width: size.width + textInsets.left + textInsets.right,
            height: size.height + textInsets.top + textInsets.bottom
        )
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }

    func configure(text: String, backgroundColor: UIColor, textColor: UIColor = .white) {
        self.text = text
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        isHidden = false
    }
}

// MARK: - Setup

private extension BadgePillView {
    func setupLabel() {
        font = .systemFont(ofSize: 11, weight: .bold)
        textColor = .white
        clipsToBounds = true
        isHidden = true
    }
}
