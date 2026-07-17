//
//  ProductDetailViewController.swift
//  ExampleProject-VIPER
//
//  Created by Burak Özdemir on 16.07.2026.
//

import UIKit
import SnapKit

final class ProductDetailViewController: UIViewController {

    // MARK: - Properties

    private let presenter: ProductDetailPresenterProtocol

    private let reviews: [Review] = []

    private var reviewsTableViewHeightConstraint: Constraint?

    // MARK: - Scroll Content

    private let scrollView = UIScrollView()

    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()

    // MARK: - Image Section

    private let imageSectionView = UIView()

    private lazy var imagePagingCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeImagePagingLayout())
        collectionView.backgroundColor = .systemGray6
        collectionView.register(ImagePageView.self, forCellWithReuseIdentifier: ImagePageView.reuseIdentifier)
        collectionView.dataSource = self
        return collectionView
    }()

    private let pageIndicatorView = PageIndicatorView(numberOfDots: 3)

    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .label
        button.backgroundColor = .white
        button.layer.cornerRadius = 18
        return button
    }()

    private let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .label
        button.backgroundColor = .white
        button.layer.cornerRadius = 18
        return button
    }()

    // MARK: - Info Section

    private let infoSectionView = UIView()

    private let brandLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = AppColors.brandBlue
        return label
    }()

    private let ratingView = RatingView()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        return label
    }()

    private let newPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26, weight: .bold)
        return label
    }()

    private let oldPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .secondaryLabel
        label.isHidden = true
        return label
    }()

    private lazy var priceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [newPriceLabel, oldPriceLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .firstBaseline
        return stackView
    }()

    private let discountBadgeView = BadgePillView()

    private lazy var priceSectionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [priceStackView, discountBadgeView])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        return stackView
    }()

    // MARK: - Description Section

    private let descriptionSectionView = UIView()

    private let descriptionHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Ürün Açıklaması"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()

    private let descriptionBodyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Info Grid Section

    private let infoBoxContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 12
        return view
    }()

    private let stockInfoView = InfoGridItemView()
    private let shippingInfoView = InfoGridItemView()
    private let warrantyInfoView = InfoGridItemView()
    private let returnInfoView = InfoGridItemView()

    // MARK: - Disclosure Section

    private let disclosureRowView = DisclosureRowView(title: "Teknik Özellikler")

    // MARK: - Reviews Section

    private let reviewsSectionView = UIView()

    private let reviewsHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Değerlendirmeler"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()

    private let reviewsCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()

    private let seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tümünü Gör", for: .normal)
        button.setTitleColor(AppColors.brandBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        return button
    }()

    private lazy var reviewsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ReviewCardView.self, forCellReuseIdentifier: ReviewCardView.reuseIdentifier)
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        return tableView
    }()

    // MARK: - Bottom Bar

    private let bottomBarContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()

    private let bottomBarHairlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()

    private lazy var addToCartButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Sepete Ekle"
        configuration.image = UIImage(systemName: "cart")
        configuration.imagePadding = 8
        configuration.baseBackgroundColor = AppColors.brandBlue
        configuration.cornerStyle = .large
        return UIButton(configuration: configuration)
    }()

    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        reviewsTableViewHeightConstraint?.updateOffset(reviewsTableView.contentSize.height)
    }

    // MARK: - Inits

    init(presenter: ProductDetailPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup

private extension ProductDetailViewController {
    func setupView() {
        view.backgroundColor = .systemBackground
        addViews()
        configureConstraints()
    }

    func addViews() {
        view.addViews(scrollView, bottomBarContainerView)
        scrollView.addViews(contentStackView)

        imageSectionView.addViews(imagePagingCollectionView, pageIndicatorView, backButton, shareButton)
        infoSectionView.addViews(brandLabel, ratingView, titleLabel, priceSectionStackView)
        descriptionSectionView.addViews(descriptionHeaderLabel, descriptionBodyLabel)
        infoBoxContainerView.addViews(stockInfoView, shippingInfoView, warrantyInfoView, returnInfoView)
        reviewsSectionView.addViews(reviewsHeaderLabel, reviewsCountLabel, seeAllButton, reviewsTableView)
        bottomBarContainerView.addViews(bottomBarHairlineView, addToCartButton)

        [
            imageSectionView,
            infoSectionView,
            makeDivider(),
            descriptionSectionView,
            infoBoxContainerView,
            disclosureRowView,
            makeDivider(),
            reviewsSectionView
        ].forEach { contentStackView.addArrangedSubview($0) }
    }

    func configureConstraints() {
        configureScrollConstraints()
        configureImageSectionConstraints()
        configureInfoSectionConstraints()
        configureDescriptionSectionConstraints()
        configureInfoGridConstraints()
        configureDisclosureConstraints()
        configureReviewsSectionConstraints()
        configureBottomBarConstraints()
    }

    func configureScrollConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(bottomBarContainerView.snp.top)
        }

        contentStackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
    }

    func configureImageSectionConstraints() {
        imageSectionView.snp.makeConstraints { make in
            make.height.equalTo(340)
        }

        imagePagingCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(320)
        }

        pageIndicatorView.snp.makeConstraints { make in
            make.top.equalTo(imagePagingCollectionView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(6)
        }

        backButton.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(12)
            make.width.height.equalTo(36)
        }

        shareButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(12)
            make.width.height.equalTo(36)
        }
    }

    func configureInfoSectionConstraints() {
        brandLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
        }

        ratingView.snp.makeConstraints { make in
            make.centerY.equalTo(brandLabel)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(16)
            make.width.equalTo(80)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(brandLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        priceSectionStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
    }

    func configureDescriptionSectionConstraints() {
        descriptionHeaderLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
        }

        descriptionBodyLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionHeaderLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }

    func configureInfoGridConstraints() {
        [stockInfoView, shippingInfoView, warrantyInfoView, returnInfoView].forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(40)
            }
        }

        stockInfoView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
        }

        shippingInfoView.snp.makeConstraints { make in
            make.top.equalTo(stockInfoView)
            make.leading.equalTo(stockInfoView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(stockInfoView)
        }

        warrantyInfoView.snp.makeConstraints { make in
            make.top.equalTo(stockInfoView.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
            make.width.equalTo(stockInfoView)
        }

        returnInfoView.snp.makeConstraints { make in
            make.top.equalTo(warrantyInfoView)
            make.leading.equalTo(warrantyInfoView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
            make.width.equalTo(shippingInfoView)
        }
    }

    func configureDisclosureConstraints() {
        disclosureRowView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }

    func configureReviewsSectionConstraints() {
        reviewsHeaderLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
        }

        reviewsCountLabel.snp.makeConstraints { make in
            make.leading.equalTo(reviewsHeaderLabel.snp.trailing).offset(6)
            make.centerY.equalTo(reviewsHeaderLabel)
        }

        seeAllButton.snp.makeConstraints { make in
            make.centerY.equalTo(reviewsHeaderLabel)
            make.trailing.equalToSuperview().inset(16)
        }

        reviewsTableView.snp.makeConstraints { make in
            make.top.equalTo(reviewsHeaderLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
            reviewsTableViewHeightConstraint = make.height.equalTo(0).constraint
        }
    }

    func configureBottomBarConstraints() {
        bottomBarContainerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }

        bottomBarHairlineView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }

        addToCartButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(12)
            make.height.equalTo(50)
        }
    }

    func makeDivider() -> UIView {
        let dividerView = UIView()
        dividerView.backgroundColor = .systemGray5
        dividerView.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        return dividerView
    }

    func makeImagePagingLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging

        return UICollectionViewCompositionalLayout(section: section)
    }
}

// MARK: - ProductDetailViewProtocol

extension ProductDetailViewController: ProductDetailViewProtocol {

}

// MARK: - UICollectionViewDataSource

extension ProductDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: ImagePageView.reuseIdentifier, for: indexPath)
    }
}

// MARK: - UITableViewDataSource

extension ProductDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reviews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: ReviewCardView.reuseIdentifier, for: indexPath)
    }
}
