//
//  ViewController.swift
//  BookRentalAapp
//
//  Created by Eliel Vipata on 7/20/21.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var data:[[String:Any?]] = []
    @IBOutlet weak var seachBar: UISearchBar!
    var filteredData:[[String:Any?]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        seachBar.delegate = self
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        let width = (view.frame.size.width - layout.minimumInteritemSpacing*2) / 3
        layout.itemSize = CGSize(width: width, height: width*3/2)
        getData()
        
    }
    
    func getData(){
        API.bookSearch() { (data) in
            self.data = data!
            self.filteredData = data!
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath) as! BookCell
        
        let book = self.data[indexPath.item];
        let volumeInfo = book["volumeInfo"] as! [String:Any]
        let linksExist = volumeInfo["imageLinks"]
        if(linksExist != nil){
            let imageLinks = volumeInfo["imageLinks"] as! [String:Any]
            let thumbnail=imageLinks["thumbnail"] as! String
            let posterUrl = URL(string: thumbnail)
            cell.bookCover.af_setImage(withURL:posterUrl!)
        }else{
            cell.bookCover.image = UIImage(named: "Inbox-Empty-icon")
        }
    
        cell.book = Book(dictionary: volumeInfo)
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.count != 0){
            if(searchText.contains(" ") && searchText.count == 1){
                return
            }
            data = filteredData
            let newSearch = searchText.replacingOccurrences(of: " ", with: "+")
            API.manualSearch(query: newSearch) { (data) in
                self.data = data!
                self.collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailsSegue", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "detailsSegue"){
            if let indexPath = sender as? IndexPath {
                let data = self.data[indexPath.item]
                let volumeInfo = data["volumeInfo"] as! [String:Any]
                let book = Book(dictionary: volumeInfo)
                let detailsViewController = segue.destination as! DetailsViewController
                detailsViewController.book = book
            }
        }
    }
}

