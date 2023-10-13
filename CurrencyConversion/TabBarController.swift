//
//  TabBarController.swift
//  CurrencyConversion
//
//  Created by 신정원 on 2023/10/13.
//


import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tabBar.items?[0].title = "Picker"
        self.tabBar.items?[0].image = UIImage(systemName: "filemenu.and.selection")
        
       
        self.tabBar.items?[1].title = "Table"
        self.tabBar.items?[1].image = UIImage(systemName: "list.bullet")
        
    }
}
