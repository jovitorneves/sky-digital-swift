//
//  sky_digital_swiftTests.swift
//  sky-digital-swiftTests
//
//  Created by joao.vitor.f.naves on 04/10/19.
//  Copyright © 2019 vitor.neves. All rights reserved.
//

import XCTest
@testable import sky_digital_swift

class sky_digital_swiftTests: XCTestCase {
    
    //MARK: - Properties
    var moviesVC: MoviesViewController!
    var movieDetailVC: MovieDetailViewController!
    var movie: Movie?

    //MARK: - CicleLife
    override func setUp() {
        movieDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MovieDetailViewController") as? MovieDetailViewController
        moviesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MoviesViewController") as? MoviesViewController
        
        moviesVC.preload()
        movieDetailVC.preload()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //MARK: - Tests
    //MARK: - RequestManager
    func testRequestManager(){
        RequestManager.shared.get("\(APISession.APIEndPoint)/Movies", model: [Movie].self, completion: { (responseMovie) in
            XCTAssertNotNil(responseMovie)
            self.movie = responseMovie?.first
            self.testMovieDetail(movie: responseMovie?.first)
            XCTAssertNotNil(responseMovie)
        }) { (error) in
            XCTAssertNil(error)
        }
    }
    
    //MARK: - MovieDetailViewController
    func testMovieDetail(movie: Movie?){
        
        movieDetailVC.movie = movie
        movieDetailVC.viewDidLoad()
        
        if let imgMovie = movie?.coverURL{
            movieDetailVC.movieIV?.loadAndCacheImage(from: imgMovie)
        }
        
        XCTAssertEqual(movieDetailVC.titleLbl.text, "Titulo: Doutor Estranho")
        XCTAssertEqual(movieDetailVC.durationLbl.text, "Duração: 1h 55m")
        XCTAssertEqual(movieDetailVC.launchLbl.text, "Lançamento: 2017")
        XCTAssertNotNil(movie)
    }
    
    //MARK: - Movies TableView
    func testNumerRowsTableView() {
        moviesVC.movies = []

        for index in 1...5 {
            let movie = Movie(title: "Titulo: \(index)", overview: "Desconhecido", duration: "0", releaseYear: "\(index)", coverURL: "", backdropsURL: [], id: "")
            moviesVC.movies.append(movie)
            print("INDEX \(index)")
        }
        
        XCTAssertEqual(moviesVC.collectionView.numberOfItems(inSection: 0), 5, "Numero de rows na collection deve ser igual a 5")
    }

}
