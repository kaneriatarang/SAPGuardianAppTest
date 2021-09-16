//
//  AppDelegate.swift
//  SAPGuardianApp
//
//  Created by Tarang Kaneriya on 13/09/21.
//

import UIKit
import BackgroundTasks

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Start Network Reachanility Monitoring
        let _ = ReachabilityManager.shared.startMonitoring(withLog: true)
        
        // Registering Background task to fetch News when app in background
        registerBackgroundTasks()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func registerBackgroundTasks() {
        // Declared at the "Permitted background task scheduler identifiers" in info.plist
        let backgroundAppProcessingTaskSchedulerIdentifier = "com.SAPGuardianApp.searchNews"
        
        BGTaskScheduler.shared.register(forTaskWithIdentifier: backgroundAppProcessingTaskSchedulerIdentifier, using: nil) { (task) in
            print("BackgroundAppRefreshTaskScheduler is executed NOW!")
            print("Background time remaining: \(UIApplication.shared.backgroundTimeRemaining)s")
            
            let homeViewModel = HomeViewModel(manager: HomeManager())
            task.expirationHandler = {
                task.setTaskCompleted(success: false)
            }
            homeViewModel.reloadData = {
                task.setTaskCompleted(success: true)
            }
            homeViewModel.fetchNewsInBackGroud()
            
            self.scheduleBackgroundNewsFetch()
        }
    }
    
    func scheduleBackgroundNewsFetch() {
        // Declared at the "Permitted background task scheduler identifiers" in info.plist
        let backgroundAppProcessingTaskSchedulerIdentifier = "com.SAPGuardianApp.searchNews"
        //Task Scheduler Time
        let timeDelay = 60.0
        
        do {
            let backgroundAppRefreshTaskRequest = BGProcessingTaskRequest(identifier: backgroundAppProcessingTaskSchedulerIdentifier)
            backgroundAppRefreshTaskRequest.earliestBeginDate = Date(timeIntervalSinceNow: timeDelay)
            try BGTaskScheduler.shared.submit(backgroundAppRefreshTaskRequest)
            print("Submitted task request")
        } catch {
            print("Unable to submit task: \(error.localizedDescription)")
        }
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        scheduleBackgroundNewsFetch()
    }
    
}

