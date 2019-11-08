//
//  MainCoordinator.swift
//  sky-digital-swift
//
//  Created by joao.vitor.f.naves on 07/11/19.
//  Copyright © 2019 vitor.neves. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    //MARK: - properties
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    //MARK: - init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MoviesViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    //MARK: - MoviesViewController
    func goToMovieDetail(movie: Movie!){
        let vc = MovieDetailViewController.instantiate()
        vc.coordinator = self
        vc.movie = movie
        navigationController.pushViewController(vc, animated: true)
    }
    
}
