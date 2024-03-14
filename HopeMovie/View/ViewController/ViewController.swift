//
//  ViewController.swift
//  HopeMovie
//
//  Created by Umut Erol on 10.02.2024.
//

import UIKit
import FirebaseAuth
import RxSwift
import RxCocoa

class ViewController: UIViewController , UICollectionViewDelegate{
   
   
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    @IBOutlet weak var btn_trending: UIButton!
    @IBOutlet weak var btn_onDisplay: UIButton!
    @IBOutlet weak var btn_upComing: UIButton!
    @IBOutlet weak var btn_topRated: UIButton!
    
    
    var checkButtonColor = String()
        
    let movieViewModel = MovieViewModel()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        checkButtonColor = "trending"

        movieCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        setupBinding()
        movieViewModel.requestData()
        movieCollectionView.reloadData()
        
        
        self.selectedItemCollectionView()
        self.resetToButtonColor()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        btn_upComing.layer.cornerRadius = 20
        btn_trending.layer.cornerRadius = 20
        btn_topRated.layer.cornerRadius = 20
        btn_onDisplay.layer.cornerRadius = 20
       
        
    }
    
    
    private func setupBinding() {

        
        movieViewModel
            .error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { errorString in
                print(errorString)
            }
            .disposed(by: disposeBag)
        
        
        movieViewModel
            .movieList
            .asObservable()
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: self.movieCollectionView.rx.items(cellIdentifier: "movieInfoCell",cellType: MovieCollectionViewCell.self)) { row, item, cell in
                cell.item = item
            }.disposed(by: disposeBag)
        
                
    }
    
    @IBAction func goToFavoriteVCButton(_ sender: Any) {
        let favoriteVC = storyboard?.instantiateViewController(identifier: "toFavoriteVC") as! FavouritesViewController
        navigationController?.pushViewController(favoriteVC, animated: true)
    }
    
    @IBAction func clicked_onDisplay(_ sender: Any) {
        
        movieCollectionView.delegate = nil
        movieCollectionView.dataSource = nil
        
        movieViewModel.requestData(movieCategoryStringRequest: "now_playing")
        movieCollectionView.reloadData()
        setupBinding()
        
        self.checkButtonColor = "onDisplay"
        self.resetToButtonColor()
    }
    
    
    @IBAction func clicked_trending(_ sender: Any) {
        movieCollectionView.delegate = nil
        movieCollectionView.dataSource = nil
          
        movieViewModel.requestData(movieCategoryStringRequest: "popular")
        movieCollectionView.reloadData()
        setupBinding()
        
        self.checkButtonColor = "trending"
        self.resetToButtonColor()
    }
    
    
    @IBAction func clicked_upComing(_ sender: Any) {
        
        movieCollectionView.delegate = nil
        movieCollectionView.dataSource = nil
        
        movieViewModel.requestData(movieCategoryStringRequest: "upcoming")
        movieCollectionView.reloadData()
        setupBinding()
        
        self.checkButtonColor = "upComing"
        self.resetToButtonColor()

    }
    
    
    
    @IBAction func clicked_topRated(_ sender: Any) {
        movieCollectionView.delegate = nil
        movieCollectionView.dataSource = nil
        
        movieViewModel.requestData(movieCategoryStringRequest: "top_rated")
        movieCollectionView.reloadData()
        setupBinding()
        
        self.checkButtonColor = "topRated"
        self.resetToButtonColor()

    }
    
    
    
    func resetToButtonColor() {
        self.btn_trending.backgroundColor = .black
        self.btn_onDisplay.backgroundColor = .black
        self.btn_topRated.backgroundColor = .black
        self.btn_upComing.backgroundColor = .black
        
        switch self.checkButtonColor {
        case "trending" :
            self.btn_trending.backgroundColor = .systemIndigo
        case "onDisplay":
            self.btn_onDisplay.backgroundColor = .systemIndigo
        case "topRated":
            self.btn_topRated.backgroundColor = .systemIndigo
        case "upComing":
            self.btn_upComing.backgroundColor = .systemIndigo
       
        default:
            print("default")
        }
    }
    
    
    
    func selectedItemCollectionView() {
        
        // CollectionView'da bir hücre seçildiğinde
        movieCollectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
        guard let self = self else { return }
                let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "toDetailsVC") as? DetailsViewController
                detailsVC?.results = movieViewModel.movies[indexPath.row]
                self.navigationController?.pushViewController(detailsVC!, animated: true)
       
                   })
                   .disposed(by: disposeBag)
    }
    
    
    }


    
    

