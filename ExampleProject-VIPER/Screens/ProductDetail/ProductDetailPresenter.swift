//
//  ProductDetailPresenter.swift
//  ExampleProject-VIPER
//
//  Created by Burak Özdemir on 16.07.2026.
//

import Foundation

class ProductDetailPresenter {
    weak var view: ProductDetailViewProtocol?
    private let interactor: ProductDetailInteractorProtocol
    private let router: ProductDetailRouterProtocol
    
    init(
        interactor: ProductDetailInteractorProtocol,
        router: ProductDetailRouterProtocol
    ) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - ProductDetailPresenterProtocol Methods

extension ProductDetailPresenter: ProductDetailPresenterProtocol {
    
}

// MARK: - ProductDetailInteractorOutputProtocol Methods

extension ProductDetailPresenter: ProductDetailInteractorOutputProtocol {
    
}
