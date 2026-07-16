//
//  ProductDetailContracts.swift
//  ExampleProject-VIPER
//
//  Created by Burak Özdemir on 16.07.2026.
//

import Foundation

// MARK: - ProductDetailViewProtocol

protocol ProductDetailViewProtocol: AnyObject { }

// MARK: - ProductDetailInteractorProtocol

protocol ProductDetailInteractorProtocol: AnyObject { }

// MARK: - ProductDetailInteractorOutputProtocol

protocol ProductDetailInteractorOutputProtocol: AnyObject { }

// MARK: - ProductDetailPresenterProtocol

protocol ProductDetailPresenterProtocol: AnyObject { }

// MARK: - ProductDetailRouterProtocol

protocol ProductDetailRouterProtocol: AnyObject { }

// MARK: - ProductDetailBuilderProtocol

protocol ProductDetailBuilderProtocol: AnyObject {
    static func makeModule() -> ProductDetailViewController
}
