//
//  ProductListBuilder.swift
//  ExampleProject-VIPER
//
//  Created by Burak Özdemir on 16.07.2026.
//

import Foundation

class ProductListBuilder: ProductListBuilderProtocol {
    static func makeModule() -> ProductListViewController {
        let router = ProductListRouter()
        let interactor = ProductListInteractor()
        let presenter = ProductListPresenter(
            interactor: interactor,
            router: router
        )
        let view = ProductListViewController(presenter: presenter)
        
        interactor.output = presenter
        router.view = view
        presenter.view = view
        
        return view
    }
}
