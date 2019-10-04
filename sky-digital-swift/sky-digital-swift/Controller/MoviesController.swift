//
//  MoviesController.swift
//  sky-digital-swift
//
//  Created by joao.vitor.f.naves on 04/10/19.
//  Copyright © 2019 vitor.neves. All rights reserved.
//

import UIKit

//MARK: - typealias
typealias completionMovies = ([Movie]?) -> Void
typealias failure = (Error) -> Void

//MARK: - Protocol
protocol MoviesControllerProtocol {
    func getMovies(completion: @escaping completionMovies, failure: @escaping failure)
    func goToMovieDetail(movie: Movie)
}

class MoviesController: MoviesControllerProtocol {
    
    //MARK: - Properties
    var viewController: MoviesViewController?
    
    //MARK: - CicleLife
    init(_ viewController: MoviesViewController) {
        self.viewController = viewController
    }
    
    //MARK: - Requisicao
    func getMovies(completion: @escaping completionMovies, failure: @escaping failure){
        RequestManager.shared.get("\(APISession.APIEndPoint)/Movies", model: [Movie].self, completion: { (moviesResponse) in
            completion(moviesResponse)
        }) { (error) in
            failure(error)
        }
    }
    
    //MARK: - Router
    func goToMovieDetail(movie: Movie){
        let movieDetail = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        movieDetail.movie = movie
        self.viewController?.navigationController?.pushViewController(movieDetail, animated: true)
    }
}
