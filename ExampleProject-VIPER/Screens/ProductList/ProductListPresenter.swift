//
//  ProductListPresenter.swift
//  ExampleProject-VIPER
//
//  Created by Burak Özdemir on 16.07.2026.
//

import Foundation

class ProductListPresenter {
    weak var view: ProductListViewProtocol?
    private let interactor: ProductListInteractorProtocol
    private let router: ProductListRouterProtocol
    
    init(
        interactor: ProductListInteractorProtocol,
        router: ProductListRouterProtocol
    ) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - ProductListPresenterProtocol Methods

extension ProductListPresenter: ProductListPresenterProtocol {
    
}

// MARK: - ProductListInteractorOutputProtocol Methods

extension ProductListPresenter: ProductListInteractorOutputProtocol {
    
}
