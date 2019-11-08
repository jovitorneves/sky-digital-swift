//
//  Coordinator.swift
//  sky-digital-swift
//
//  Created by joao.vitor.f.naves on 07/11/19.
//  Copyright © 2019 vitor.neves. All rights reserved.
//

import Foundation
import UIKit

//MARK: - protocol
protocol Coordinator {
    //MARK: - Properties
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
