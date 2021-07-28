//
//  ItemDetailPresenter.swift
//  CleanVIP
//
//  Created by Alexandre C do Carmo on 27/07/21.
//

import Foundation

protocol itemDetailPresenter: AnyObject {
    func interactor(didRetrieveItem item: Items)
    func interactor(didFailRetrieveItem error: Error)
}


class itemDetailPresenterImplementation: itemDetailPresenter {
    
    var viewController: ItemDetailPresenterOutput?
    
    func interactor(didRetrieveItem item: Items) {
        
        let itemString = item.text
        
        viewController?.presenter(didRetrieveItem: itemString ?? "")
    }
    
    func interactor(didFailRetrieveItem error: Error) {
        viewController?.presenter(didFailRetrieveItem: error.localizedDescription)
    }
    
}
