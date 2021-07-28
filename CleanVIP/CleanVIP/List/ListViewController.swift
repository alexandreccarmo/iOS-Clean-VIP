//
//  ListViewController.swift
//  CleanVIP
//
//  Created by Alexandre C do Carmo on 27/07/21.
//

import Foundation
import UIKit


protocol ListPresenterOutPut: AnyObject {
    
    func presenter(didRetrieveItems items: [String])
    func presenter(didFailRetrieveItems message: String)
    
    func presenter(didAddItem item: String)
    func presenter(didFailAddItem message: String)
    
    func presenter(didDeleteItemAtIndex index: Int)
    func presenter(didFailDeleteItemAtIndex index: Int, message: String)
    
    func presenter(didObtainItemId id: String)
    func presenter(didFailObtainItemId message: String)
}

class ListViewController: UIViewController {
    
    
    var listView: ListView?
    var interactor: ListInteractor?
    var router: ListRouter?
    
    private var items: [String] = []
    
    override func loadView() {
        super.loadView()
        
        self.view = listView
        
        listView?.tableView.delegate = self
        listView?.tableView.dataSource = self
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "Items"
        self.navigationItem.rightBarButtonItem = addBarButtonItem
        
    }
    
    @objc func addBarButtonItemTapped() {
           let alert = UIAlertController(
               title: "Adicionar novo item",
               message: nil,
               preferredStyle: .alert
           )
           
           alert.addTextField { (textField) in
               textField.placeholder = "Texto"
           }
           
           let okAction = UIAlertAction(
               title: "Adicionar",
               style: .default
           ) { [unowned self] (action) in
               self.interactor?.addTapped(with: alert.textFields?.first?.text ?? "")
           }
           
           let cancelAction = UIAlertAction(
               title: "Cancelar",
               style: .cancel,
               handler: nil
           )
           
           alert.addAction(okAction)
           alert.addAction(cancelAction)
           present(alert, animated: true, completion: nil)
   }
    
    lazy var addBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addBarButtonItemTapped)
        )
        return item
    }()

}

extension ListViewController: ListPresenterOutPut {
    func presenter(didRetrieveItems items: [String]) {
        self.items = items
        self.listView?.reloadTableView()
    }
    
    func presenter(didFailRetrieveItems message: String) {
        showError(with: message)
    }
    
    func presenter(didAddItem item: String) {
        self.items.append(item)
        self.listView?.insertRow(at: self.items.count - 1)
    }
    
    func presenter(didFailAddItem message: String) {
        showError(with: message)
    }
    
    func presenter(didDeleteItemAtIndex index: Int) {
        self.items.remove(at: index)
        self.listView?.deleteRow(at: index)
    }
    
    func presenter(didFailDeleteItemAtIndex index: Int, message: String) {
        showError(with: message)
    }
    
    func presenter(didObtainItemId id: String) {
        self.router?.routeToDetail(with: id)
    }
    
    func presenter(didFailObtainItemId message: String) {
        showError(with: message)
    }
    
    
    func showError(with: String){
        let alert = UIAlertController(title: "Atenção", message: with, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.items.isEmpty ? self.listView?.showPlaceHolder() : self.listView?.hidePlaceholder()
        
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView .dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = self.items[indexPath.row]
                cell.selectionStyle = .none
                return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
           self.interactor?.didCommitDelete(for: indexPath.row)
       }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.interactor?.didSelectRow(at: indexPath.row)
    }
    
}
