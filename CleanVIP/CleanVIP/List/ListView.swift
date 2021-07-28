//
//  ListView.swift
//  CleanVIP
//
//  Created by Alexandre C do Carmo on 27/07/21.
//

import Foundation
import UIKit

class ListView: UIView {
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableView: UITableView = {
           let tableView = UITableView()
           tableView.rowHeight = 80
           tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
           tableView.translatesAutoresizingMaskIntoConstraints = false
           return tableView
       }()
       
       lazy var placeholderTextLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont(name: "Avenir-Heavy", size: 25)
           label.text = "Nenhum item adicionado!"
           label.textColor = .darkGray
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
    
    public func showPlaceHolder(){
        UIView.animate(withDuration: 0.3){
            self.placeholderTextLabel.alpha = 1.0
            self.tableView.alpha = 0.0
        }
    }
    
    public func hidePlaceholder() {
        UIView.animate(withDuration: 0.3) {
            self.placeholderTextLabel.alpha = 0.0
            self.tableView.alpha = 1.0
        }
    }
    
    public func reloadTableView() {
        self.tableView.reloadData()
    }
    
    public func insertRow(at index: Int, section: Int = 0) {
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [
            IndexPath(
                row: index,
                section: section
            )
        ], with: .automatic)
        self.tableView.endUpdates()
    }
    
    public func deleteRow(at index: Int, section: Int = 0) {
        self.tableView.beginUpdates()
        self.tableView.deleteRows(at: [
            IndexPath(
                row: index,
                section: section
            )
        ], with: .automatic)
        self.tableView.endUpdates()
    }
    
}

extension ListView {
    private func setupUI(){
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        self.backgroundColor = .white
        
        self.addSubview(tableView)
        self.addSubview(placeholderTextLabel)
        
        
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: self.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            placeholderTextLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            placeholderTextLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
    }
}
