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
    var refid : String
    var profilename : String
    var profileimage : String
}

struct apicontestsharedon
{
    var groupid : Int
    var groupname : String
    var date : Date
    var contestid : Int
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
                                                        var ref = ""
                                                        var pim = ""
                                                        var pnm = ""
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
                                                     
                                                        if let ff = each["Ref_guid"] as? String {
                                                            ref = ff
                                                        }
                                                        if let ff = each["ProfileImg"] as? String {
                                                            pim = ff
                                                        }
                                                        if let ff = each["ProfileName"] as? String {
                                                            pnm = ff
                                                        }
                                                        
                                                        if !self.isEntityAttributeExist(id: c) {        self.createPerson(fn: f, ln: l, nu: c, onser: s , ref : ref ,pim : pim , pnm : pnm)
                                                        }
                                                        else {
                                                            self.updateifsiffer(fn : f , ln : l , nu : c , onser : s, ref : ref ,pim : pim , pnm : pnm)
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
    
    public func updateifsiffer(fn: String, ln: String, nu: String , onser : Bool , ref : String, pim :String, pnm : String )
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
    
    
//    public func createContestShare(groupname: String, groupid: Int, sharedon: Date  ){
//
//        let context = persistentContainer.viewContext
//        let contact = NSEntityDescription.insertNewObject(forEntityName: "Contestsharedingroup", into: context)
//        contact.groupid = groupname
//        contact.groupname = groupid
//        contact.sharedon = sharedon
//
//
//
//        do {
//            try context.save()
//            print("✅ Contest saved succesfuly with name \(groupname) groupid \(groupid) and sharedon \(sharedon)")
//
//        } catch let error {
//            print("❌ Failed to create Person: \(error.localizedDescription)")
//        }
//    }
    public func notifycoredataaboutshare(shareon : [groupevent] , cid : Int )
    {
        print("Reached CoreData")
        
        let context = persistentContainer.viewContext
        for each in shareon {
            let entity = NSEntityDescription.entity(forEntityName: "Contestsharedingroup", in: context)
            let newUser = NSManagedObject(entity: entity!, insertInto: context)
            var t = NSNumber(integerLiteral: each.groupid)
            var u = NSNumber(integerLiteral: cid)
            newUser.setValue(t, forKey: "groupid")
            newUser.setValue("\(each.groupname)", forKey: "groupname")
            newUser.setValue(Date(), forKey: "sharedon")
            newUser.setValue(u, forKey: "contestid")
            do {
                try context.save()
                print("Saved")
            } catch {
                print("Failed saving")
            }
        }
        
        
    }
    
    public func deletecrossedgroups()
    {
        
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contestsharedingroup")
        
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            
            for data in result as! [NSManagedObject] {
                
                var z = data.value(forKey: "sharedon") as? Date
                if Date().timeIntervalSince(z ?? Date()) > (24 * 60 * 60) {
                    print("Deleting \(data)")
                    context.delete(data)
                }
                
            }
           
            
        } catch {
            
            print("Failed")
        }
        
    }
    
    
    public func readfromcoredata() -> [apicontestsharedon]
    {
        var datafromapi : [apicontestsharedon] = []
        
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contestsharedingroup")
        
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            
            for data in result as! [NSManagedObject] {
                var x = data.value(forKey: "groupname") as? String
                var y = data.value(forKey: "groupid") as? Int
                var z = data.value(forKey: "sharedon") as? Date
                var w = data.value(forKey: "contestid") as? Int ?? 0
                var xx = apicontestsharedon(groupid: y ?? 0, groupname: x ?? "" , date: z ?? Date(), contestid: w)
                datafromapi.append(xx)
            }
            print("Date Obtained From ApI")
            return datafromapi
            print(datafromapi)
            
        } catch {
            
            print("Failed")
        }
        return []
    }
    
    
    public func createPerson(fn: String, ln: String, nu: String , onser : Bool , ref : String, pim :String, pnm : String ){
            
            let context = persistentContainer.viewContext
            let contact = NSEntityDescription.insertNewObject(forEntityName: "Customcontact", into: context) as! Customcontact
        contact.name = fn
        contact.lastname = ln
        contact.number = nu
        contact.onserver = onser
        contact.refguid = ref
        contact.profimage = pim
        contact.profname = pnm
        
            
            
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
                    var x = apicontact(Contact: person.number ?? "", FirstName: person.name ?? "" , LastName: person.lastname ?? "", onserver: person.onserver ?? false, refid: person.refguid ?? "" , profilename: person.profname ?? "" , profileimage: person.profimage ?? "")
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
