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
    
//        print(CoreDataManager.sharedInstance.persistentContainer.persistentStoreDescriptions)
//
//
//        let nf = Folder.newFolder(name: "Aaaa")
//        nf.addNote().name = "New Note"
//        nf.addNote().name = "New Note"
//        nf.addNote().name = "New Note"
//        nf.addNote().name = "New Note"
//        nf.addNote().name = "New Note"
//
//        CoreDataManager.sharedInstance.saveContext()
//        print(folders.count)
//        print(folders[0].name)
//
//        print(notes.count)
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataManager.sharedInstance.saveContext()
    }

}

