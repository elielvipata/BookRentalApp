//
//  DetailsViewController.swift
//  BookRentalAapp
//
//  Created by Eliel Vipata on 7/23/21.
//

import UIKit
import AlamofireImage

class DetailsViewController: UIViewController {
    var book:Book?
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
        
        author.text = authorString
        
        bookTitle.text = book?.title
        let count : Int = book?.page_count ?? 0
        bookPages.text = String(count)
        bookPublishDate.text = "Published on: \(book?.publishedDate))"
        bookDescription.text = book?.description
        let thumbUrl = URL(string: book?.thumbnail ?? "")
        bookThumbnail.af_setImage(withURL:thumbUrl!)
        // Do any additional setup after loading the view.
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
