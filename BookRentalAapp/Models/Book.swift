//
//  Book.swift
//  BookRentalAapp
//
//  Created by Eliel Vipata on 7/22/21.
//

import Foundation
import Parse

class Book{
//    - title
//    - description
//    - authors
//    - thumbnail
//    - page count
//    - edition
//    - published date
    
    var title:String?
    var description:String?
    var authors:[String]?
    var thumbnail:String?
    var page_count:Int?
    var publishedDate:String?
    var id:String?
    var dictionary:[String:Any?]
    var rented:Bool
    var returned:Bool
    var user:PFUser
    var bookID:String?
    
    
    init(dictionary: [String:Any]) {
        self.title = dictionary["title"] as? String
        self.description = dictionary["description"] as? String
        self.authors = dictionary["authors"] as? [String]
        self.page_count = dictionary["pageCount"] as? Int
        self.publishedDate = dictionary["publishedDate"] as? String
        
        let linksExist = dictionary["imageLinks"]
        if(linksExist != nil){
            let imageLinks = dictionary["imageLinks"] as! [String:Any]
            let thumbnail=imageLinks["thumbnail"] as! String
            self.thumbnail = thumbnail
        }else{
            self.thumbnail = "nil"
        }
        
        self.dictionary = dictionary
        self.returned = false
        self.rented = false
        self.user = PFUser.current()!
    }
    
}
