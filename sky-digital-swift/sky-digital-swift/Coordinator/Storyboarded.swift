//
//  Storyboarded.swift
//  sky-digital-swift
//
//  Created by joao.vitor.f.naves on 07/11/19.
//  Copyright © 2019 vitor.neves. All rights reserved.
//

import Foundation
import UIKit

//MARK: - protocol
protocol Storyboarded {
    static func instantiate() -> Self
}

//MARK: - extension
extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
    
}
