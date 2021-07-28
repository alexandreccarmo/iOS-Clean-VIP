//
//  ItemDetailInteractor.swift
//  CleanVIP
//
//  Created by Alexandre C do Carmo on 27/07/21.
//

import Foundation

protocol ItemDetailInteractor: AnyObject {
    var itemId: String? { get }
        
    func viewDidLoad()
}

class ItemDetailInteractorImplamentation: ItemDetailInteractor {
    var itemId: String?
    var presenter: itemDetailPresenter?
    private let itemService = ListServiceImplementation()
    
    func viewDidLoad() {
        do {
            
            if let item = try itemService.getItem(with: self.itemId!){
                presenter?.interactor(didRetrieveItem: item)
            }
            
        } catch  {
            presenter?.interactor(didFailRetrieveItem: error)
        }
    }
    
}
