//
//  AppDelegate.swift
//  ShowTalent
//
//  Created by apple on 8/30/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import Contacts
import CoreData
import IQKeyboardManagerSwift
import Firebase
import UserNotifications




@UIApplicationMain
 class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
  //  var reachability: Reachability?
    var contactStore = CNContactStore()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
      
      
         IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.previousNextDisplayMode = .default
        

        UILabel.appearance().font = UIFont(name: "NeusaNextStd-Regular", size: 16)
            Minorlabel.appearance().font = UIFont(name: "NeusaNextStd-Regular", size: 18)


          UITextField.appearance().font = UIFont(name: "NeusaNextStd-Regular", size: 16)


        
        
        
//     let bool =  UserDefaults.standard.bool(forKey: "isLogin")
//       // let bool = UserDefaults.standard.value(forKey: "isLogin")
//        if (bool){
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "tabbars") as! TabBarViewController
//            let navigationController = UINavigationController(rootViewController: nextViewController)
//            let appdelegate = UIApplication.shared.delegate as! AppDelegate
//            appdelegate.window!.rootViewController = navigationController
//
//
////            var nextViewController = UIViewController()
////
////            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
////            nextViewController = storyBoard.instantiateViewController(withIdentifier: "OnboardVC") as! OnboardingViewController
////            let navigationController = UINavigationController(rootViewController: nextViewController)
////            let appdelegate = UIApplication.shared.delegate as! AppDelegate
////            appdelegate.window!.rootViewController = navigationController
////
//
//
//
//        }//OnboardVC
//        else
//        {
//            var nextViewController = UIViewController()
//
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                         nextViewController = storyBoard.instantiateViewController(withIdentifier: "OnboardVC") as! OnboardingViewController
//                        let navigationController = UINavigationController(rootViewController: nextViewController)
//                        let appdelegate = UIApplication.shared.delegate as! AppDelegate
//                        appdelegate.window!.rootViewController = navigationController
//
//        }
        
//        FirebaseApp.configure()
//        Messaging.messaging().delegate = self as! MessagingDelegate
//        Messaging.messaging().isAutoInitEnabled = true

        // [END set_messaging_delegate]
        // Register for remote notifications. This shows a permission dialog on first run, to
        // show the dialog at a more appropriate time move this registration accordingly.
        // [START register_for_notifications]
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self as! UNUserNotificationCenterDelegate

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        } else {
          let settings: UIUserNotificationSettings =
          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()

        
        return true
    }
  
    func requestForAccess(completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        let authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        print("status is")
        print(authorizationStatus)
     
        switch authorizationStatus {
        case .authorized:
            completionHandler(true)
        
        case .denied, .notDetermined:
            self.contactStore.requestAccess(for: CNEntityType.contacts, completionHandler: { (access, accessError) -> Void in
                if access {
                    print("Accepted ")
                    completionHandler(access)
                }
                else {
                    print("Not Accepted ")
                    if authorizationStatus == CNAuthorizationStatus.denied {
                       completionHandler(false)
                    }
                }
            })
            
        case .restricted :
            self.contactStore.requestAccess(for: CNEntityType.contacts, completionHandler: { (access, accessError) -> Void in
                if access {
                    print("Accepted ")
                    completionHandler(access)
                }
                else {
                    print("Not Accepted ")
                    if authorizationStatus == CNAuthorizationStatus.denied {
                       completionHandler(false)
                    }
                }
            })
     
        default:
            completionHandler(false)
        }
    }
    
    
    func makenewfetchrequest(completionHandler: @escaping (_ accessGranted: Bool) -> Void)
    {
        let authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
    
        self.contactStore.requestAccess(for: CNEntityType.contacts, completionHandler: { (access, accessError) -> Void in
            if access {
                print("Accepted ")
                completionHandler(access)
            }
            else {
                print("Not Accepted ")
                if authorizationStatus == CNAuthorizationStatus.denied {
                   completionHandler(false)
                }
            }
        })
    }
    
    
    
    
//    func application(application: UIApplication,
//                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        let deviceTokenString = deviceToken.hexString
//        print("Device Token : \(deviceTokenString)")
////        Messaging.messaging().apnsToken = deviceToken as Data
//    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken
       print("Device Token : \(deviceTokenString)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    

        // Print full message.
        print("FCM \(userInfo)")

    }
    
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

//    func getCategory()
//    {//noauth
//     //   ProgressHUD.show()
//        UserDefaults.standard.set(false, forKey: "noauth")
//        let request = BaseServiceClass()
//        request.getApiRequest(url: Constants.K_baseUrl+Constants.getCategory, parameters: [:]) { (response, err) in
//            if response != nil{
//                let decoder = JSONDecoder()
//                let jsondata = try! decoder.decode(RegisterResponse<Datas>.self, from: (response?.data!)!)
//                if jsondata.ResponseStatus == 0 {
//                    print("usercat")
//                    print(jsondata.Results?.Data_1 as Any)
//                    //                   cat
//
//                  //  self.catregories = (jsondata.Results?.Data_1)!
//                UserDefaults.standard.set(jsondata.Results?.Data_1, forKey: "AllCatergories")
//
//                }
//                else {
//                  //  ProgressHUD.dismiss()
//                }
//            }
//            else{
//             //   ProgressHUD.dismiss()
//            }
//        }
//    }
//
//
//
//    func showAlerts(title : String, message : String) {
//        let alert = UIAlertController(title: title, message: message,         preferredStyle: UIAlertController.Style.alert)
//
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
//            //Cancel Action
//        }))
//
//        self.window?.rootViewController!.present(alert, animated: true, completion: nil)
//    }
//
//    func GetUserCategory()
//
//    {//noauth
//    //   ProgressHUD.show()
//    UserDefaults.standard.set(false, forKey: "noauth")
//    let request = BaseServiceClass()
//    request.getApiRequest(url: Constants.K_baseUrl+Constants.getUserCat, parameters: [:]) { (response, err) in
//    if response != nil{
//    let decoder = JSONDecoder()
//        let jsondata = try! decoder.decode(RegisterResponse<Datas>.self, from: (response?.data!)!)
//    if jsondata.ResponseStatus == 0 {
//
//    //                   cat
//
//        print("selectedcat")
//        print(jsondata.Results?.Data_1 as Any)
//    //  self.catregories = (jsondata.Results?.Data_1)!
//    UserDefaults.standard.set(jsondata.Results?.Data_1, forKey: "UserCategory")
//
//    }
//    else {
//    //  ProgressHUD.dismiss()
//    }
//    }
//    else{
//    //   ProgressHUD.dismiss()
//    }
//    }
//    }
//
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "ShowTalent")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    
}

extension UIButton {
   @IBInspectable
    var isHeading: Bool {
        get {
            return isHeading
        }
        set {
            if newValue == false {
                self.titleLabel?.font =  UIFont(name: "NeusaNextStd-Regular", size: 18)
            }
            else {
                 self.titleLabel?.font =  UIFont(name: "ProximaNova-Bold", size: 18)
            }
        }
    
        
    
    }
}



@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {

  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    let userInfo = notification.request.content.userInfo

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)
    // Print message ID.
  

    // Print full message.
    print("FCM \(userInfo)")

    // Change this to your preferred presentation option
    completionHandler([])
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo
    // Print message ID.
 
    // Print full message.
    print("FCM \(userInfo)")

    completionHandler()
  }
}
// [END ios_10_message_handling]

//extension AppDelegate : MessagingDelegate {
//  // [START refresh_token]
//  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
//    print("FCM Firebase registration token: \(fcmToken)")
//
//    let dataDict:[String: String] = ["token": fcmToken]
//    NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
//    // TODO: If necessary send token to application server.
//    // Note: This callback is fired at each app startup and whenever a new token is generated.
//  }
//  // [END refresh_token]
//  // [START ios_10_data_message]
//  // Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
//  // To enable direct data messages, you can set Messaging.messaging().shouldEstablishDirectChannel to true.
//  func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
//    print("FCM Received data message: \(remoteMessage.appData)")
//  }

  // [END ios_10_data_message]


