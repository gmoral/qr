//
//  AccessDisplayable.swift
//  QR
//
//  Created by Guillermo Moral on 28/04/2023.
//

import UIKit

protocol AccessCameraMessageDisplayable {
    func denid()
    func authorized()
}

extension AccessCameraMessageDisplayable where Self: UIViewController {
    
    func presentAccessCamera(message: String, title: String) {
        
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancelar",
                                     style: .cancel,
                                     handler: {(action: UIAlertAction!) in
            self.denid()
        })
        
        let setupAction = UIAlertAction(title: "Habilitar cámara",
                                     style: .default,
                                     handler: {(action: UIAlertAction!) in
                                        print(">> configuracion <<")
            self.authorized()
        })
          
        alertController.addAction(cancelAction)
        alertController.addAction(setupAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
}
