//
//  DetailsViewController.swift
//  BookRentalAapp
//
//  Created by Eliel Vipata on 7/23/21.
//

import UIKit
import AlamofireImage
import Parse



class DetailsViewController: UIViewController {
    var book:Book?
    var books:[Book] = []

    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookPages: UILabel!
    @IBOutlet weak var bookEdition: UILabel!
    @IBOutlet weak var bookPublishDate: UILabel!
    @IBOutlet weak var bookDescription: UILabel!
    @IBOutlet weak var bookThumbnail: UIImageView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        var authorString = ""
    
        for current in book!.authors ?? [] {
            authorString.append(current)
            authorString.append(" ")
        }
        
        updateCartBadge()
        

        
        author.text = authorString
        
        bookTitle.text = book?.title
        let count : Int = book?.page_count ?? 0
        bookPages.text = String(count)
        bookPublishDate.text = "Published on: \(book?.publishedDate))"
        bookDescription.text = book?.description
        let thumbUrl = URL(string: book?.thumbnail ?? "")
        bookThumbnail.af.setImage(withURL:thumbUrl!)
        // Do any additional setup after loading the view.
    }
    @IBAction func onAddButton(_ sender: Any) {
        let bookToUpload = PFObject(className: "Book", dictionary: self.book?.dictionary)
        bookToUpload["user"] = [self.book!.user]
        bookToUpload["rented"] = [self.book!.rented]
        bookToUpload["returned"] = [self.book!.returned]
        
        bookToUpload.saveInBackground { [self] (success,error) in
            if((error) != nil){
                print(error?.localizedDescription)
            }else if(success){
                self.books.append(self.book!)
                let userDefaults = UserDefaults.standard
                let total = userDefaults.integer(forKey: "cart_total")
                userDefaults.setValue(total+1, forKey: "cart_total")
                updateCartBadge()
                
                let alert = UIAlertController(title: "Nice", message: "Book added to cart", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: NSLocalizedString("Checkout", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                    self.tabBarController?.selectedIndex = 2
                }))
                
                alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
                    print("Continuing")
                }))
                
                self.present(alert, animated: true, completion: nil)
            }
            
        }
    }
    
    
    func updateCartBadge(){
        //Update Cart Badge Count
        let userDefaults = UserDefaults.standard
        let total = userDefaults.integer(forKey: "cart_total")
        if(total > 0){
            self.tabBarController?.tabBar.items![2].badgeValue = String(total)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
