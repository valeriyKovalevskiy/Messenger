//
//  AppDelegate.swift
//  Messenger
//
//  Created by Valeriy Kovalevskiy on 7/14/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//


import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    weak var screen : UIView? = nil
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()

//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = ChatViewController()
//        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {}
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {}
    
    //MARK: - Secure sensitive data methods
    func applicationWillResignActive(_ application: UIApplication) {
        showBlurScreen()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        removeBlurScreen()
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return Auth.auth().canHandle(url)
    }
    
}
//MARK: - Hide sensitive data methods
extension AppDelegate {
    fileprivate func showBlurScreen(style: UIBlurEffect.Style = UIBlurEffect.Style.regular) {
        screen = UIScreen.main.snapshotView(afterScreenUpdates: false)
        let blurEffect = UIBlurEffect(style: style)
        let blurBackground = UIVisualEffectView(effect: blurEffect)
        screen?.addSubview(blurBackground)
        blurBackground.frame = (screen?.frame)!
        window?.addSubview(screen!)
    }

    fileprivate func removeBlurScreen() {
        screen?.removeFromSuperview()
    }
}

