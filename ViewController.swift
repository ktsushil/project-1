//
//  ViewController.swift
//  project1
//
//  Created by Tacktile Mac3 on 10/12/18.
//  Copyright © 2018 Tacktile Mac3. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var book:[Book]=[]
 
    @IBOutlet weak var tablView: UITableView!
    @IBAction func addbutn(_ sender: Any) {
        let actionSheet=UIAlertController(title: nil, message: "ADD BOOK&AUTHOR", preferredStyle: .actionSheet)
        let search=UIAlertAction(title: "search", style: .default){
            action in
            let mainstoryboard=UIStoryboard(name: "Main",bundle: nil)
            let vc = mainstoryboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
            let navigationcontroller=UINavigationController(rootViewController: vc)
            self.present(navigationcontroller, animated: true, completion: nil)
        }
        
        let book=UIAlertAction(title: "BOOK", style: .default){
            action in
            let mainstoryboard=UIStoryboard(name: "Main",bundle: nil)
            let vc = mainstoryboard.instantiateViewController(withIdentifier: "Saveviewcontroller") as! saveviewcontroller
//            self.present(vc, animated: true, completion: nil)
             self.navigationController?.pushViewController(vc, animated: true)
        }
        let cancel=UIAlertAction(title:"CANCEL", style: .cancel, handler: nil)
        actionSheet.addAction(book)
        actionSheet.addAction(search)
        actionSheet.addAction(cancel)
        present(actionSheet, animated: true, completion: nil)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return book.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
       let str=book[indexPath.row]

        cell.bookName.text=str.name
        let allauthors=str.authors?.allObjects as! [Author]
        var authorName:String=""
        
        for author in allauthors{
           print("author.name = \(author.name)")
            authorName=authorName+" "+(author.name ?? "")
             print("authorName \(authorName)")
            
            }
        print("authorName final= \(authorName)")
        cell.authorName.text=authorName
         return cell
        
//        var arra:[String]=["ram","mohan","aryan"]
//        var name:String=""
//        for arr in arra{
//            name=name+arr
//        }
//        print(name)
        //        cell.bookName.text="PHYSIC"
        //        cell.authorName.text="HERALD SAMUEL, ALYSIA GREEN, HYRA JAY, lEE KUN, TYLER WAYNE,RYAN HARRIS,NAID HASSAN,PRABHU SWANHEY, ALYSIA ROOD"
//        let allBooks = author.tobook?.allObjects as! [Book]
//        var booksName = ""
//        for book in allBooks {
//            booksName = book.bookName ?? "" + ", "
//        }
//        cell.book.text=booksName
//
//        //
//        ////                + "" + name.secondName!
//        return cell
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      tablView.delegate=self
        tablView.dataSource=self
         self.fetchData()
         self.tablView.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func fetchData()
    {
        let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
           book=try context.fetch(Book.fetchRequest())
        }
        catch{
            print("error")
        }
    }
 func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        if editingStyle == .delete{
           let user=book[indexPath.row]
           context.delete(user)
           (UIApplication.shared.delegate as! AppDelegate).saveContext()
           do{
               book=try context.fetch(Book.fetchRequest()) as! [Book]
               self.tablView.reloadData()
           }
           catch{
              print("error")
           }
            
       }
   }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath:
        IndexPath) {
        let book = self.book[indexPath.row]
        let mainstoryboard=UIStoryboard(name: "Main",bundle: nil)
        let vc = mainstoryboard.instantiateViewController(withIdentifier: "Saveviewcontroller") as! saveviewcontroller
        vc.book = book
        
       self.navigationController?.pushViewController(vc, animated: true)
//        self.navigationController?.present(vc, animated: true)
        
    }
    

}

