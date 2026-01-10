//
//  UIHelper.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 10.01.26.
//


import UIKit

struct UIHelper {
    static func configureNavigationBar(for controller: UIViewController, title: String, showBackButton: Bool = false) {
        controller.title = title
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "background")
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        if let navBar = controller.navigationController?.navigationBar {
            navBar.standardAppearance = appearance
            navBar.scrollEdgeAppearance = appearance
            navBar.tintColor = .white
        }
        
        if showBackButton {
            let backButton = UIBarButtonItem(
                image: UIImage(systemName: "chevron.left"),
                style: .plain,
                target: controller,
                action: #selector(controller.backToHomeAction)
            )
            controller.navigationItem.leftBarButtonItem = backButton
        }
    }
}

extension UIViewController {
    @objc func backToHomeAction() {
        self.tabBarController?.selectedIndex = 0
    }
}
