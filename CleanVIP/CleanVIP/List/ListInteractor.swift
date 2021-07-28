//
//  ListInteractor.swift
//  CleanVIP
//
//  Created by Alexandre C do Carmo on 27/07/21.
//

import Foundation

protocol ListInteractor: AnyObject {
    func viewDidLoad()
    func addTapped(with text:String)
    
    func didCommitDelete(for index: Int)
    
    func didSelectRow(at index: Int)
}

class ListInteractorImplementation: ListInteractor {
    
    var presenter: ListPresenter?
    
    private let listService = ListServiceImplementation()
    private var items: [Items] = []
        
    
    func viewDidLoad() {
        
        do {
            self.items = try listService.getItems()
            presenter?.interactor(didRetrieveItems: self.items)
        }catch {
            presenter?.interactor(didFailRetrieveItems: error)
        }
        
    }
    
    func addTapped(with text: String) {
        do {
            let item = try listService.addItems(text: text)
            self.items.append(item)
            
            presenter?.interactor(didAddItem: item)
        } catch {
            presenter?.interactor(didFailAddItem: error)
        }
    }
    
    func didCommitDelete(for index: Int) {
        do {
            try listService.deleteItem(with: self.items[index].id!)
            self.items.remove(at: index)
            presenter?.interactor(didDeleteItemAtIndex: index)
        } catch  {
            presenter?.interactor(didFailDeleteItemAtIndex: index)
        }
    }
    
    func didSelectRow(at index: Int) {
        if self.items.indices.contains(index) {
            presenter?.interactor(didFindItem: self.items[index])
        }
    }
    
    
}
