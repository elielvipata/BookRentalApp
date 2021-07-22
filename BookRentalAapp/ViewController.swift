//
//  ViewController.swift
//  BookRentalAapp
//
//  Created by Eliel Vipata on 7/20/21.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var data:[[String:Any?]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
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
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count;
    }

}

