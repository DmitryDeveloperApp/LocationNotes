//
//  AppDelegate.swift
//  LocationNotes
//
//  Created by Dmitry Suprun on 28.05.2022.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = ViewController()
//        window?.makeKeyAndVisible()
    
        print(CoreDataManager.sharedInstance.persistentContainer.persistentStoreDescriptions)
         
         _ = Folder.newFolder(name: "NewFolder")
         CoreDataManager.sharedInstance.saveContext()
        
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataManager.sharedInstance.saveContext()
    }

}

