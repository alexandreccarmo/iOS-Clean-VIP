//
//  ItemDetailView.swift
//  CleanVIP
//
//  Created by Alexandre C do Carmo on 27/07/21.
//

import Foundation
import UIKit

class ItemDetailView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateLabel(with text: String) {
        itemLabel.text = text
    }
    
    lazy var itemLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 25)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

extension ItemDetailView {
    
    private func setupUI() {
           if #available(iOS 13.0, *) {
               overrideUserInterfaceStyle = .light
           }
           self.backgroundColor = .white
           
           self.addSubview(itemLabel)
           
           NSLayoutConstraint.activate([
                itemLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                itemLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
           ])
       }
}
