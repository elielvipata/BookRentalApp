//
//  CartViewController.swift
//  BookRentalAapp
//
//  Created by Eliel Vipata on 7/28/21.
//

import UIKit
import Parse
import AlamofireImage

class CartViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var objects=[PFObject?]()
    var books=[Book]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        getCartData()
        // Do any additional setup after loading the view.
    }
    
    func getCartData(){
        API.getCart(){ (data) in
            
            if(data != nil){
                
                if(data.count == 0 ){
                    self.tableView.alpha = 0
                }
                
                for current in data{
                    var dictionary:[String:Any] = [:]
                    dictionary["title"]  = current!["title"] as? String
                    dictionary["description"] = current!["description"] as? String
                    dictionary["authors"] = current!["authors"] as? [String]
                    dictionary["pageCount"] = current!["pageCount"] as? Int
                    dictionary["publishedDate"] = current!["publishedDate"] as? String
                    dictionary["objectId"] = current!["objectId"] as? String
                    dictionary["imageLinks"] = current!["imageLinks"]
                    let book = Book(dictionary: dictionary)
                    book.bookID = current!["objectId"] as? String
                    self.books.append(book)
                }
                self.objects = data
                self.tableView.reloadData()
            }else{
                print("Error retrieving books for cart")
            }
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartCell
        let book = books[indexPath.row]
        cell.book = book
        cell.titleLabel.text = book.title
        let thumbUrl = URL(string: book.thumbnail ?? "")
        cell.thumbnail.af.setImage(withURL:thumbUrl!)
        cell.object = objects[indexPath.row]
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let userDefaults = UserDefaults.standard
        let total = userDefaults.integer(forKey: "cart_total")
        
        if(self.books.count != total && books.count != 0){
            books.removeAll()
            getCartData()
        }
        
//        books.removeAll()
//        getCartData()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        let userDefaults = UserDefaults.standard
//        let total = userDefaults.integer(forKey: "cart_total")
//
//        if(self.books.count != total){
//            books.removeAll()
//            getCartData()
//        }
////        books.removeAll()
////        getCartData()
//    }
    
    
    func updateCartBadge(){
        //Update Cart Badge Count
        let userDefaults = UserDefaults.standard
        let total = userDefaults.integer(forKey: "cart_total")
        if(total > 0){
            self.tabBarController?.tabBar.items![2].badgeValue = String(total)
        }
    }
    @IBAction func onCheckoutButton(_ sender: Any) {
        
        self.performSegue(withIdentifier: "checkoutSegue", sender: nil)
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
