//
//  Network.swift
//  BookRentalAapp
//
//  Created by Eliel Vipata on 7/20/21.
//

import Foundation
import Parse

struct API{
    
    static func signup(username:String, password:String, completion: @escaping ([[String:Any]]?) -> Void){

        let applicationId = "1234test"
        let url = URL(string: "http://192.168.1.9:1337/parse/users")!
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        request.addValue(applicationId, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("1", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(username, forHTTPHeaderField: "username")
        request.addValue(password, forHTTPHeaderField: "password")
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let books = dataDictionary["results"] as! [[String:Any]]
                return completion(books)
                
            }
        }
        
        task.resume()
    }
    
    static func bookSearch (completion: @escaping ([[String:Any]]?) -> Void) {
        let apikey = "AIzaSyA67wIEXoKqQHal2H7BzxhVrPNWzRSD498"
                
        let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=algorithms&key=\(apikey)")!
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let books = dataDictionary["items"] as! [[String:Any]]
                return completion(books)
                
            }
        }
        
        task.resume()
    }
    
    static func manualSearch (query:String, completion: @escaping ([[String:Any]]?) -> Void) {
        let apikey = "AIzaSyA67wIEXoKqQHal2H7BzxhVrPNWzRSD498"
                
       let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=\(query)&key=\(apikey)")!
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let books = dataDictionary["items"] as! [[String:Any]]
                return completion(books)
            }
        }
        
        task.resume()
    }
    
    static func getCart (completion: @escaping ([PFObject?]) -> Void) {
        let user = PFUser.current()!
        let query = PFQuery(className: "Book")
        query.whereKey("user", equalTo: user)
        query.whereKey("rented", equalTo: false)
        query.whereKey("returned", equalTo: false)
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (books, error) in
            if(books != nil){
                let bookData = books! as [PFObject]
                return completion(bookData)
            }
        }
    }
}

    

