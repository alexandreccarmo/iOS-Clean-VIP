//
//  ItemDetailViewController.swift
//  CleanVIP
//
//  Created by Alexandre C do Carmo on 27/07/21.
//

import Foundation
import UIKit

protocol ItemDetailPresenterOutput: AnyObject {
    func presenter(didRetrieveItem item: String)
    func presenter(didFailRetrieveItem message: String)
}


class ItemDetailViewController: UIViewController {
    
    var itemDetailView: ItemDetailView?
    var interactor: ItemDetailInteractor?
    weak var presenter: ItemDetailPresenter?
    
    override func loadView() {
        super.loadView()
        
        self.view = itemDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactor?.viewDidLoad()
    }
}


extension ItemDetailViewController: ItemDetailPresenterOutput{
    func presenter(didRetrieveItem item: String) {
        itemDetailView?.updateLabel(with: item)
    }
    
    func presenter(didFailRetrieveItem message: String) {
        showError(with: message)
    }
    
    func showError(with: String){
        let alert = UIAlertController(title: "Atenção", message: with, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
