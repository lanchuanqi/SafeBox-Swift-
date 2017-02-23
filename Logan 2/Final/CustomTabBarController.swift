//
//  CustomTabBarController.swift
//  Final
//
//  Created by logan on 8/10/15.
//  Copyright (c) 2015 logan. All rights reserved.
//


import UIKit


class CustomTabBarController: UITabBarController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier , identifier == "LoginSegue" {
            if let loginNavController = segue.destination as? UINavigationController,
               let loginVieWController = loginNavController.topViewController as? LoginViewController,
               let loginViewControllerDelegate = sender as? LoginViewControllerDelegate {
               loginVieWController.delegate = loginViewControllerDelegate
            }
        }
        else {
            super.prepare(for: segue, sender: sender)
        }
    }
}
