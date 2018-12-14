//
//  SearchViewController.swift
//  project1
//
//  Created by Tacktile Mac3 on 10/12/18.
//  Copyright © 2018 Tacktile Mac3. All rights reserved.
//

import UIKit
import CoreData

class SearchViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
   
    
   
    @IBOutlet weak var showLabel: UILabel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @objc func backAction() -> Void {
//        self.navigationController?.popViewController(animated: true)
//
        let mainstoryboard=UIStoryboard(name: "Main",bundle: nil)
        let vc = mainstoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let navigationcontroller=UINavigationController(rootViewController: vc)
        self.present(navigationcontroller, animated: true, completion: nil)
    }
    
        override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backAction))
        
         self.navigationItem.leftBarButtonItem = backButton
        
       
        searchBar.delegate = self
        filteredData = book
            
//
//            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//
//            let query:NSFetchRequest<Book> = Book.fetchRequest()
//            let key = "alex"
//
//            let predicate = NSPredicate(format: "name contains[c] %@", key)
//            query.predicate = predicate
//
//            do{
//                book = try context.fetch(query)
//                print(book.count)
//
//            }catch{
//                print("error")
//            }
        
        
        

        // Do any additional setup after loading the view.
    }
     var book:[Book]=[]
//    let data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
//                "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
//                "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
//                "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
//                "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]
    
    var filteredData: [Book]!
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) 
        let str = filteredData[indexPath.row]
         cell.textLabel?.text=str.name
        return cell
//        let str=book[indexPath.row]
//
//        cell.bookName.text=str.name
//        let allauthors=str.authors?.allObjects as! [Author]
//        var authorName:String=""
//
//        for author in allauthors{
//            print("author.name = \(author.name)")
//            authorName=authorName+" ,"+(author.name ?? "")
//            print("authorName \(authorName)")
//
//        }
//        print("authorName final= \(authorName)")
//        cell.authorName.text=authorName
//        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    // This method updates filteredData based on the text in the Search Box
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        // When there is no text, filteredData is the same as the original data
//        // When user has entered text into the search box
//        // Use the filter method to iterate over all items in the data array
//        // For each item, return true if the item should be included and false if the
//        // item should NOT be included
//
//
//
//        filteredData = searchText.isEmpty ? book : book.filter { (item: Book) -> Bool in
//            // If dataItem matches the searchText, return true to include it
//            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
//        }
//
//        tableView.reloadData()
//    }
//
    
 
   //here starts the code
    
    @IBAction func searchButn(_ sender: UIButton) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Book")
        let SearchString=self.searchBar?.text
        request.predicate=NSPredicate(format: "name==%@", SearchString!)
        do{
            let result = try context.fetch(request)
            if result.count>0
            {
                let names=(result[0] as AnyObject).value(forKey: "name")as! String
                self.showLabel?.text=names
                
            }
            else{self.showLabel?.text="no book"
                
            }
        }
        catch{
            print("error")
            
        }
        
    }
    


}
