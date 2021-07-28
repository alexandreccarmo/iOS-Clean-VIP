//
//  ItemDetailConfigurator.swift
//  CleanVIP
//
//  Created by Alexandre C do Carmo on 27/07/21.
//

import Foundation
class ItemDetailConfigurator {

    static func configureModule(itemId: String, viewController: ItemDetailViewController) {
        let view = ItemDetailView()
        let interactor = ItemDetailInteractorImplamentation()
        let presenter = ItemDetailPresenterImplementation()
        
        interactor.itemId = itemId

        viewController.itemDetailView = view
        viewController.interactor = interactor

        interactor.presenter = presenter
        
        presenter.viewController = viewController
    }
}
