//
//  ProductListContracts.swift
//  ExampleProject-VIPER
//
//  Created by Burak Özdemir on 16.07.2026.
//

import Foundation

// MARK: - ProductListViewProtocol

protocol ProductListViewProtocol: AnyObject { }

// MARK: - ProductListInteractorProtocol

protocol ProductListInteractorProtocol: AnyObject { }

// MARK: - ProductListInteractorOutputProtocol

protocol ProductListInteractorOutputProtocol: AnyObject { }

// MARK: - ProductListPresenterProtocol

protocol ProductListPresenterProtocol: AnyObject { }

// MARK: - ProductListRouterProtocol

protocol ProductListRouterProtocol: AnyObject { }

// MARK: - ProductListBuilderProtocol

protocol ProductListBuilderProtocol: AnyObject {
    static func makeModule() -> ProductListViewController
}
