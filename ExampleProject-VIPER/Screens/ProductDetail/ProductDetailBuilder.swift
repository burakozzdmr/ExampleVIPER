//
//  ProductDetailBuilder.swift
//  ExampleProject-VIPER
//
//  Created by Burak Özdemir on 16.07.2026.
//

import Foundation

class ProductDetailBuilder: ProductDetailBuilderProtocol {
    static func makeModule() -> ProductDetailViewController {
        let router = ProductDetailRouter()
        let interactor = ProductDetailInteractor()
        let presenter = ProductDetailPresenter(
            interactor: interactor,
            router: router
        )
        let view = ProductDetailViewController(presenter: presenter)
        
        interactor.output = presenter
        router.view = view
        presenter.view = view
        
        return view
    }
}
