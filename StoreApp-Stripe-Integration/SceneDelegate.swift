//
//  SceneDelegate.swift
//  StoreApp-Stripe-Integration
//
//  Created by Leo Leljak on 02/06/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabBar()
        window?.makeKeyAndVisible()
        
    }

    
    func createTabBar() -> UITabBarController{
        let tabBar = UITabBarController()
        UITabBar.appearance().tintColor = .systemBlue
        tabBar.viewControllers = [createProductViewController(), createCartViewController()]
        
        return tabBar
    }
    
    
    func createProductViewController() -> UINavigationController {
        let productVC = ProductsViewController()
        productVC.title = "Store Catalog"
        let bagImage = UIImage(systemName: SFSymbols.store)
        let bagImageFilled = UIImage(systemName: SFSymbols.storeFilled)
        productVC.tabBarItem = UITabBarItem(title: Constants.storeTitle , image: bagImage, selectedImage: bagImageFilled)
        
        let navigationVC = UINavigationController(rootViewController: productVC)
        
        return navigationVC
    }
    
    
    func createCartViewController() -> UIViewController {
        let cartVC = CartViewController()
        let cartImage = UIImage(systemName: SFSymbols.cart)
        let cartImageFilled = UIImage(systemName: SFSymbols.cartFilled)
        cartVC.tabBarItem = UITabBarItem(title: Constants.cartTitle, image: cartImage, selectedImage: cartImageFilled)
        
        return cartVC
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

