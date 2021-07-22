//
//  Network.swift
//  BookRentalAapp
//
//  Created by Eliel Vipata on 7/20/21.
//

import Foundation

struct API{
    
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
    }}
