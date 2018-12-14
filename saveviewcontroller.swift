//
//  saveviewcontroller.swift
//  project1
//
//  Created by Tacktile Mac3 on 10/12/18.
//  Copyright © 2018 Tacktile Mac3. All rights reserved.
//

import UIKit
import CoreData

class saveviewcontroller: UIViewController {
     let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var BookName: UITextField!
    
    @IBOutlet weak var authorName: UITextField!
    @IBOutlet weak var authorName2: UITextField!
    
    var book: Book!
    var isnew:Bool=false
    @IBAction func Back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backAction))
        self.navigationItem.leftBarButtonItem = backButton
        
        
        let saveButton = UIBarButtonItem(title: "save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveAction))
        
        self.navigationItem.rightBarButtonItem = saveButton
        
        
        if book != nil{
            self.BookName.text = book.name
            if let allauthors = book.authors?.allObjects as? [Author] {
                if allauthors.indices.contains(0) {
                    let author = allauthors[0]
                    authorName.text=author.name
                }
                
                if allauthors.indices.contains(1) {
                    authorName2.text=allauthors[1].name
                }
            }
        }
       
            
        
        // Do any additional setup after loading the view.
    }
    
//    @IBAction func saveButn(_ sender: Any) {
//        if BookName?.text != "" && authorName?.text != "" && authorName2?.text != ""
//        {
//
//            let book=NSEntityDescription.insertNewObject(forEntityName: "Book", into: context) as! Book
//            book.setValue(self.BookName!.text, forKey: "name")
//         let author1=NSEntityDescription.insertNewObject(forEntityName: "Author", into: context) as! Author
//         author1.setValue(self.authorName!.text, forKey: "name")
//            author1.addToBooks(book)
//            print("author name=\(author1)")
//            let author2=NSEntityDescription.insertNewObject(forEntityName: "Author", into: context) as! Author
//            author2.setValue(self.authorName2!.text, forKey: "name")
//             author2.addToBooks(book)
//             print("author name=\(author2)")
////           author2.addToTobook(book)
//
//
//            do
//            {
//                try context.save()
//            }
//            catch{
//                print("error")
//            }
//        }
//        else
//        {
//            print("please fill first name and second name")
//        }
//
//
//    }
    @objc func saveAction() -> Void {
        self.navigationController?.popViewController(animated: true)
        //
        if BookName?.text != "" && authorName?.text != "" && authorName2?.text != ""
        {
            if isnew{
                self.book=NSEntityDescription.insertNewObject(forEntityName: "Book", into: context) as! Book
                
            }
            book.setValue(self.BookName!.text, forKey: "name")
            if isnew{
                let author1=NSEntityDescription.insertNewObject(forEntityName: "Author", into: context) as! Author
            author1.setValue(self.authorName!.text, forKey: "name")
                author1.addToBooks(book)
                print("author name=\(author1)")}
            else {
                
                self.book.setValue(self.BookName.text, forKey: "name")
                
                if let authors = self.book.authors?.allObjects as? [Author] {
                    if authors.indices.contains(0) {
                        let author = authors[0]
                        author.setValue("authorName", forKey: "name")
                    }
            }
            }
                if isnew{
            let author2=NSEntityDescription.insertNewObject(forEntityName: "Author", into: context) as! Author
            author2.setValue(self.authorName2!.text, forKey: "name")
            author2.addToBooks(book)
            print("author name=\(author2)")
            //           author2.addToTobook(book)
                }else{
                    self.book.setValue(self.BookName.text, forKey: "name")
                    
                    if let authors = self.book.authors?.allObjects as? [Author]{
                    if authors.indices.contains(1) {
                        let author = authors[1]
                        author.setValue("authorName2", forKey: "name")
                    }
                }
                
            }

            do
            {
                try context.save()
            }
            catch{
                print("error")
            }
        }
        else
        {
            print("please fill first name and second name")
        }

    }
    @objc func backAction() -> Void {
          self.navigationController?.popViewController(animated: true)
        //
        let mainstoryboard=UIStoryboard(name: "Main",bundle: nil)
        let vc = mainstoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let navigationcontroller=UINavigationController(rootViewController: vc)
        self.present(navigationcontroller, animated: true, completion: nil)
    }
   
//    REFERENCE PURPOSE
//    func testsave() {
//        self.book.setValue(self.BookName.text, forKey: "attribute name")
//
//        if let authors = self.book.authors?.allObjects as? [Author] {
//            if authors.indices.contains(0) {
//                let author = authors[0]
//                author.setValue("Shyam", forKey: "attribute name")
//            }
//
//            if authors.indices.contains(1) {
//                let author = authors[1]
//                author.setValue("Ram", forKey: "attribute name")
//            }
//        }
//
////        savein database
//    }

    
}
