//
//  FavouritesViewController.swift
//  HopeMovie
//
//  Created by Umut Erol on 19.02.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class FavouritesViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
        
    @IBOutlet weak var tableView_favourites: UITableView!    
    var titleArray = [String]()
    var imageUrlArray = [String]()
    var overviewArray = [String]()
    var dateArray = [String]()
    var idArray = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        

        tableView_favourites.delegate = self
        tableView_favourites.dataSource = self
        
        getDocumentID_forMovie()

    }
    
    func getDocumentID_forMovie() {
        guard let user = Auth.auth().currentUser else { return }
        let currentUserID = user.uid
        
        let firestoreDatabase = Firestore.firestore()
        // "favouriteMovie" koleksiyonunu referans al
        let fav_movie_refererence = firestoreDatabase.collection("favoriteMovie")
        // Kullanıcının favori filmlerini içerecek sorguyu oluştur
        let query = fav_movie_refererence.whereField("userId", isEqualTo: currentUserID)
        
        query.getDocuments { snapshot, error in
            if error != nil {
                print("firebase error!")
            }
            else {
                for document in snapshot!.documents {
                    guard let title = document.get("title") as? String else { return }
                    self.titleArray.append(title)
                    guard let imageUrl = document.get("imageUrl") as? String else { return }
                    self.imageUrlArray.append(imageUrl)
                    guard let overview = document.get("overview") as? String else { return }
                    self.overviewArray.append(overview)
                    guard let date = document.get("date") as? String else { return }
                    self.dateArray.append(date)
                    guard let id = document.get("id") as? Int else { return }
                    self.idArray.append(id)

                }
                self.tableView_favourites.reloadData()
            }
        }

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView_favourites.dequeueReusableCell(withIdentifier: "toFavTableViewCell", for: indexPath) as! FavouriteTableViewCell
    
        cell.view_favMovieBackground.layer.cornerRadius = 45
        cell.view_favMovieBackground.clipsToBounds = true
        // Bu, görünümün köşe yarıçapını gölge oluşturulmadan önce düzgün bir şekilde kesmesini sağlar.

        
        cell.lbl_fav_movie.text = titleArray[indexPath.row]
        let imageUrlString = "https://image.tmdb.org/t/p/w500\(self.imageUrlArray[indexPath.row] ?? "")"
        if let imageUrl = URL(string: imageUrlString), let imageData = try? Data(contentsOf: imageUrl) {
            let image = UIImage(data: imageData)
            cell.imageView_fav_movie.image = image
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    
    @IBAction func clicked_back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = self.storyboard?.instantiateViewController(identifier: "toDetailsVC") as? DetailsViewController
        detailsVC?.selectedTitle = titleArray[indexPath.row]
        detailsVC?.selectedDate = dateArray[indexPath.row]
        detailsVC?.selectedOverView = overviewArray[indexPath.row]
        detailsVC?.selectedImageUrl = imageUrlArray[indexPath.row]
        detailsVC?.selectedID = idArray[indexPath.row]
        detailsVC?.controlOfSelected = true
     
        self.navigationController?.pushViewController(detailsVC!, animated: true)
        
        
    }

}
