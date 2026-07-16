//
//  ProductDetailViewController.swift
//  ExampleProject-VIPER
//
//  Created by Burak Özdemir on 16.07.2026.
//

import UIKit

class ProductDetailViewController: UIViewController {

    // MARK: - Properties
    
    private let presenter: ProductDetailPresenterProtocol
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

// MARK: - ProductDetailViewProtocol

extension ProductDetailViewController: ProductDetailViewProtocol {
    
}
