//
//  ListRouter.swift
//  CleanVIP
//
//  Created by Alexandre C do Carmo on 27/07/21.
//

import Foundation
import UIKit

protocol ListRouter: AnyObject {
    var navigationController: UINavigationController? { get }
    
    func routeToDetail(with id: String)
    
}

class ListRouterImplementation: ListRouter {
    var navigationController: UINavigationController?
    
    func routeToDetail(with id: String) {
        
        let viewController = ItemDetailViewController()
        ItemDetailConfigurator.configureModule(titleId: id, viewController: viewController)
               
        navigationController?.pushViewController(viewController, animated: true)
    }
}
