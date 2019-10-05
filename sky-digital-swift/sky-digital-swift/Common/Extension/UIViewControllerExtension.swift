//
//  UIViewControllerExtension.swift
//  sky-digital-swift
//
//  Created by joao.vitor.f.naves on 04/10/19.
//  Copyright © 2019 vitor.neves. All rights reserved.
//

import UIKit

extension UIViewController{
    
    //MARK: - Message
    func alert(title: String, message: String, action :(()->Void)? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in action?()}))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Teste Unitario
    func preload() {
        _ = self.view
    }
}
