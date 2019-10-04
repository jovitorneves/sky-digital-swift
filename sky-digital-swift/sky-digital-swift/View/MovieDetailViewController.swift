//
//  MovieDetailViewController.swift
//  sky-digital-swift
//
//  Created by joao.vitor.f.naves on 04/10/19.
//  Copyright © 2019 vitor.neves. All rights reserved.
//

import UIKit

//MARK: - Protocol
protocol MovieDetailViewControllerProtocol {
    
}

class MovieDetailViewController: UIViewController, MovieDetailViewControllerProtocol {

    //MARK: - Properties
    var movie: Movie!
    
    //MARK: - CicleLife
    override func viewDidLoad() {
        super.viewDidLoad()

        print("FILME SELECIONADO: \(self.movie)")
    }
    
}
