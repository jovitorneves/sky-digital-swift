//
//  MoviesViewController.swift
//  sky-digital-swift
//
//  Created by joao.vitor.f.naves on 04/10/19.
//  Copyright © 2019 vitor.neves. All rights reserved.
//

import UIKit
import JGProgressHUD

//MARK: - Protocol
protocol MoviesViewControllerProtocol {
    func setScreen()
    func loadMovies()
}

class MoviesViewController: UIViewController, Storyboarded, MoviesViewControllerProtocol {

    //MARK: - Properties
    weak var coordinator: MainCoordinator?
    var controller: MoviesController?
    var movies: [Movie] = []
    
    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - CicleLife
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setScreen()
        self.loadMovies()
    }

    //MARK: - Actions
    func setScreen(){
        self.controller = MoviesController(self)
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: "MovieCVC", bundle: nil), forCellWithReuseIdentifier: "MovieCVC")
    }
    
    func loadMovies(){
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Carregando"
        hud.show(in: self.view)
        
        controller?.getMovies(completion: { (movies) in
            guard let movies = movies else{
                return
            }
            self.movies = movies
            self.collectionView.reloadData()
            hud.dismiss(afterDelay: 3.0)
        }, failure: { (error) in
            self.alert(title: "Atenção", message: error.localizedDescription)
            hud.dismiss(afterDelay: 3.0)
        })
    }

}

//MARK: - CollectionView
extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard self.movies.indices.contains(indexPath.row) else{
            return UICollectionViewCell()
        }
        let movie = self.movies[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCVC", for: indexPath) as! MovieCVC
        
        cell.setCell(movie: movie)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard self.movies.indices.contains(indexPath.row) else{
            return
        }
        let movie = self.movies[indexPath.row]
        
        coordinator?.goToMovieDetail(movie: movie)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let largura = (UIScreen.main.bounds.width / 2) - 24
        return CGSize(width: largura, height: 284)
    }
    
}
