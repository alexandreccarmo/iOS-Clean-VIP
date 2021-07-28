//
//  ListConfigurator.swift
//  CleanVIP
//
//  Created by Alexandre C do Carmo on 27/07/21.
//

import Foundation
import UIKit

class ListConfigurator {
    static func configureModule(viewController: ListViewController) {
            let view = ListView()
            let router = ListRouterImplementation()
            let interactor = ListInteractorImplementation()
            let presenter = ListPresenterImplementation()
            
            viewController.listView = view
            viewController.router = router
            viewController.interactor = interactor
            
            interactor.presenter = presenter
            
            presenter.viewController = viewController
            
            router.navigationController = viewController.navigationController
        }
}
