//
//  MessageDisplayable.swift
//  ReadQR
//
//  Created by Guillermo Moral on 21/04/2023.
//

import UIKit

protocol MessageDisplayable { }

extension MessageDisplayable where Self: UIViewController {
    
    func presentAlert(message: String, title: String) {
        
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
    
}
