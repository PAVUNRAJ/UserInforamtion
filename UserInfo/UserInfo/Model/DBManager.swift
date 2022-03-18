//
//  DBManager.swift
//  UserInfo
//
//  Created by Tech on 3/18/22.
//

import Foundation

import UIKit
import CoreData

class DBManager {
    static let sharedInstance = DBManager()
    
    
    func addUser(first_name:String,last_name:String,email:String,avatar:String,id:Int64){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName:"UserInfo",
                                                in: managedContext)
        let item = NSManagedObject(entity: entity!,
                                   insertInto:managedContext) as! UserInfo
        
        item.first_name = first_name
        item.last_name = last_name
        item.email = email
        item.avatar = avatar
        item.id = id

        appDelegate.saveContext()
    }
    

    
    func fetchUserDetails()->[NSManagedObject]{
        var item = [NSManagedObject]()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:"UserInfo")
        do{
            item = try managedContext.fetch(fetchRequest)
        }
        catch let error as NSError{
            print("Counld not fetch.\(error),\(error.userInfo)")
        }
        return item
    }
}
