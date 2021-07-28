//
//  ListPresenter.swift
//  CleanVIP
//
//  Created by Alexandre C do Carmo on 27/07/21.
//

import Foundation

protocol ListPresenter: AnyObject {
    func interactor(didRetrieveItems items: [Items])
    func interactor(didFailRetrieveItems error: Error)
    
    func interactor(didAddItem item: Items)
    func interactor(didFailAddItem error: Error)
    
    func interactor(didDeleteItemAtIndex index: Int)
    func interactor(didFailDeleteItemAtIndex index: Int)
    
    func interactor(didFindItem item: Items)
}

class ListPresenterImplementation: ListPresenter {
    
    weak var viewController: ListPresenterOutPut?
    
    func interactor(didRetrieveItems items: [Items]) {
        
        let itemsString = items.compactMap { $0.text }
        viewController?.presenter(didRetrieveItems: itemsString)
    }
    
    func interactor(didFailRetrieveItems error: Error) {
        viewController?.presenter(didFailRetrieveItems: error.localizedDescription)
    }
    
    func interactor(didAddItem item: Items) {
        if let titleString = item.text {
            viewController?.presenter(didAddItem: titleString)
        }
    }
    
    func interactor(didFailAddItem error: Error) {
        viewController?.presenter(didFailAddItem: error.localizedDescription)
    }
    
    func interactor(didDeleteItemAtIndex index: Int) {
        viewController?.presenter(didDeleteItemAtIndex: index)
    }
    
    func interactor(didFailDeleteItemAtIndex index: Int) {
        viewController?.presenter(didFailDeleteItemAtIndex: index, message: "Erro ao apagar")
    }
    
    func interactor(didFindItem item: Items) {
        if let id = item.id {
            viewController?.presenter(didObtainItemId: id)
        }
    }
    
}
