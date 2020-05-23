//
//  CoreDataManager.swift
//  ShowTalent
//
//  Created by maraekat on 11/02/20.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation
import CoreData
import Contacts
import UIKit


struct apicontact
{
    var Contact : String
    var FirstName : String
    var LastName : String
    var onserver : Bool
}

class CoreDataManager
{
      public static let shared = CoreDataManager()
   
      let identifier: String  = "com.maraekat.info.ShowTalent2"
      let model: String       = "Model"
    lazy var persistentContainer: NSPersistentContainer = {
            //5
            let messageKitBundle = Bundle(identifier: self.identifier)
            let modelURL = messageKitBundle!.url(forResource: self.model, withExtension: "momd")!
            let managedObjectModel =  NSManagedObjectModel(contentsOf: modelURL)
            
    // 6.
            let container = NSPersistentContainer(name: self.model, managedObjectModel: managedObjectModel!)
            container.loadPersistentStores { (storeDescription, error) in
                
                if let err = error{
                    fatalError("❌ Loading of store failed:\(err)")
                }
            }
            
            return container
        }()
    
    
    
    func loadallfromcontacts()
    {
        var pass : [Dictionary<String,String>] = []
        GroupsandEventsContactvc.fetchcontactsforcoredata { (data, err) in
            if let d = data as? [customcontactcoredata] {
                for cont in d {
                    if let allnum = cont.number as? [String] {
                        if allnum.count == 0 {
                            continue
                        }
                        var firstnum = ""
                        if let fn = allnum[0] as? String {
                            firstnum = fn
                        }
                        if firstnum == "" {
                            continue
                        }
//                        if !self.isEntityAttributeExist(id: firstnum) {
                          firstnum = firstnum.replacingOccurrences(of: "\\s", with: "", options: .regularExpression)

                          
                            var x : Dictionary<String,String>  = ["Contact": allnum[0], "FirstName": cont.name, "LastName": cont.lastname]
                            pass.append(x)
//                        }
                    }
                    
//                var a = ""
//                    if let allnum = cont.number as? [String] {
//                    for each in allnum {
//                        if a != "" {
//                            a = a + "#" + each
//                        }
//                        else {
//                            a = a + each
//                        }
//                    }
//                }
                
//                    if self.doesexist(fn: cont.name as? String ?? "", ln: cont.lastname as? String ?? "", cnt: a) == false {
//                        self.createPerson(fn: cont.name as? String ?? "", ln: cont.lastname as? String ?? "", nu: a, onser: false)
//                    }
//                    else {
//                        print("Could not create contact with name \(cont.name) as it already exist")
//                    }
              }
                
                print("Ready to Pass")
                
                if pass.count > 0 {
                    let params  = ["RefGuid" : UserDefaults.standard.value(forKey: "refid") as! String, "Contact" : pass] as [String : Any]
                    print("hahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahah")
                    print(params)
                    print("hahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahah")

                    let r = BaseServiceClass()
                    var url = Constants.K_baseUrl + Constants.uploadcontacts
                    r.postApiRequest(url: url, parameters: params) { (response, err) in
                        print(response)
                        if let inv = response?.result.value as? Dictionary<String,Any> {
                            if let res = inv["ResponseStatus"] as? Int {
                                if res == 0 {
                                    print("Contacts uploaded")
                                    
                                    var iurl = Constants.K_baseUrl + Constants.getcontacts
                                    var iparams = ["userID": UserDefaults.standard.value(forKey: "refid") as! String]
                                    r.getApiRequest(url: iurl, parameters: iparams) { (responsee, errr) in
                                         if let resv = (responsee?.result.value) as? Dictionary<String,AnyObject> {
                                                if let usefuldata = resv["Results"] as? [Dictionary<String,Any>] {
                                                        
                                                    for each in usefuldata {
                                                        
                                                        var f = ""
                                                        var l = ""
                                                        var c = ""
                                                        var s = false
                                                        if let ff = each["FirstName"] as? String {
                                                            f = ff
                                                        }
                                                        if let ll = each["LastName"] as? String {
                                                            l = ll
                                                        }
                                                        if let cc = each["Contact"] as? String {
                                                            c = cc
                                                        }
                                                        if let ss = each["IsRegistered"] as? Bool {
                                                            s = ss
                                                        }
                                                     
                                                        
                                                        if !self.isEntityAttributeExist(id: c) {        self.createPerson(fn: f, ln: l, nu: c, onser: s)
                                                        }
                                                        else {
                                                            self.updateifsiffer(fn : f , ln : l , nu : c , onser : s)
                                                        }
                                                    }
                                                }
                                        }
                                    }
                                    
                                }
                                
                            }
                        }
                    }
                        
                    
                }
                
                
            }
        }
    }
    
    
    func isEntityAttributeExist(id: String) -> Bool {
      
      let managedContext = persistentContainer.viewContext
      let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Customcontact")
      fetchRequest.predicate = NSPredicate(format: "number == %@", id)

      let res = try! managedContext.fetch(fetchRequest)
      return res.count > 0 ? true : false
    }
    
    public func updateifsiffer(fn: String, ln: String, nu: String , onser : Bool )
    {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Customcontact>(entityName: "Customcontact")
        fetchRequest.predicate = NSPredicate(format: "number == %@ ",nu)
        do{
                       
                       let persons = try context.fetch(fetchRequest)
                       
                       for (index,person) in persons.enumerated() {
                        if person.onserver != onser {
                            person.setValue(!onser, forKey: "onserver")
                            do {
                                try context.save()
                                print("Mismatched and updated")
                                
                            }catch let error as NSError {
                              print("Mismatchecd but could not update")
                            }
                        }
                       }
                       
                       
                   }catch let fetchErr {
                       print("❌ Failed to fetch Person:",fetchErr)
                        
                   }
    }
    
    
    public func createPerson(fn: String, ln: String, nu: String , onser : Bool ){
            
            let context = persistentContainer.viewContext
            let contact = NSEntityDescription.insertNewObject(forEntityName: "Customcontact", into: context) as! Customcontact
        contact.name = fn
        contact.lastname = ln
        contact.number = nu
        contact.onserver = onser
            
            
            do {
                try context.save()
                print("✅ Person saved succesfuly with name \(fn) lastname \(ln) and number \(nu)")
                
            } catch let error {
                print("❌ Failed to create Person: \(error.localizedDescription)")
            }
        }
    public func fetch() -> [apicontact]{
            
        var newarr : [apicontact] = []
            let context = persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<Customcontact>(entityName: "Customcontact")
        let sort = NSSortDescriptor(key: #keyPath(Customcontact.name), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        fetchRequest.predicate = NSPredicate(format: "name != %@ ","")
            
            do{
                
                let persons = try context.fetch(fetchRequest)
                
                for (index,person) in persons.enumerated() {
                    var x = apicontact(Contact: person.number ?? "", FirstName: person.name ?? "" , LastName: person.lastname ?? "", onserver: person.onserver ?? false)
                    print("\(x.FirstName) and \(x.onserver)")
                    newarr.append(x)
                }
                return newarr
                
            }catch let fetchErr {
                print("❌ Failed to fetch Person:",fetchErr)
                 return newarr
            }
        }
    
    
    public func togglestatus(fn:String,ln:String,cnt:String,onServ : Bool) {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Customcontact")
        
        let p1 = NSPredicate(format: "name = %@", fn)
        let p2 = NSPredicate(format: "lastname = %@", ln)
        let p3 = NSPredicate(format: "number = %@", cnt)
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [p1,p2,p3])
        
        do {
            let retrive = try context.fetch(fetchRequest)
            let obv = retrive[0] as! Customcontact
            obv.setValue(!obv.onserver, forKey: "onserver")
        }
        catch {
            print(error)
        }
    }
    
    public func doesexist(fn:String,ln:String,cnt : String) -> Bool
    {
        
        
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Customcontact")
        
        let p1 = NSPredicate(format: "name = %@", fn)
        let p2 = NSPredicate(format: "lastname = %@", ln)
        let p3 = NSPredicate(format: "number = %@", cnt)
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [p1,p2,p3])
        do {
            let profiles = try context.fetch(fetchRequest)
            print("Tallying \(fn) , \(ln) and \(cnt)")
            print("Obtained \(profiles.count)")
            if profiles.count == 0 {
                return false
            }
            else {
                return true
            }
        } catch {
            // handle error
            print(error)
            return true
        }
    }
    
    
    func resetAllRecords() // entity = Your_Entity_Name
    {

        let context = persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Customcontact")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do
        {
            try context.execute(deleteRequest)
            try context.save()
            print("COREDATA All data deleted from coredata")
        }
        catch
        {
            print ("COREDATA There was an error")
        }
    }
    
    
}
