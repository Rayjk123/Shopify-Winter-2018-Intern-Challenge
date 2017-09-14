//
//  ViewController.swift
//  Shopify_Intern_Problem
//
//  Created by Branden Lee on 9/12/17.
//  Copyright © 2017 Panda Life. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var napolean_button = UIButton();
    var bronze_bags = UIButton();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup_navigation()
        setup_basic_constraints()
        setup_basic_UI()
        //self.title = "Shopify Intern App"
        //self.navigationBar.tintColor = UIColor.lightGreen()
        self.view.backgroundColor = UIColor.ebonyClay()
    }

    func setup_navigation() {
        let title_label = UILabel(frame: CGRect(x:0, y:0, width: UIScreen.main.bounds.width * 0.5, height: 40))
        title_label.text = "Shopify Intern App"
        title_label.textAlignment = .center
        title_label.textColor = UIColor.white
        title_label.font = UIFont(name: "Helvetica-Bold", size: 20)
        self.navigationItem.titleView = title_label
        self.navigationController?.navigationBar.barTintColor = UIColor.lightGreen()
    }
    
    func setup_basic_constraints() {
        napolean_button.translatesAutoresizingMaskIntoConstraints = false
        bronze_bags.translatesAutoresizingMaskIntoConstraints = false
        self.edgesForExtendedLayout = []
        
        self.view.addSubview(napolean_button)
        self.view.addSubview(bronze_bags)
        
        napolean_button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        napolean_button.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        napolean_button.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        napolean_button.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        bronze_bags.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bronze_bags.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bronze_bags.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        bronze_bags.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
    }

    func setup_basic_UI() {
        self.view.backgroundColor = UIColor.ebonyClay()
        
        napolean_button.backgroundColor = UIColor.cloud()
        napolean_button.setTitle("Napoleon Batz", for: .normal)
        napolean_button.setTitleColor(UIColor.lightGreen(), for: .normal)
        napolean_button.titleLabel?.font = UIFont(name: "Arial", size: 20)
        napolean_button.addTarget(self, action: #selector(go_to_napolean), for: .touchUpInside)
        
        bronze_bags.backgroundColor = UIColor.lightGreen()
        bronze_bags.setTitle("Awesome Bronze Bags", for: .normal)
        bronze_bags.setTitleColor(UIColor.white, for: .normal)
        bronze_bags.titleLabel?.font = UIFont(name: "Arial", size: 20)
        bronze_bags.addTarget(self, action: #selector(go_to_bronze), for: .touchUpInside)
    }
    
    func go_to_napolean(sender: UIButton) {
        self.navigationController?.pushViewController(NapoleanViewController(), animated: true)
    }
    
    func go_to_bronze(sender: UIButton) {
        self.navigationController?.pushViewController(BronzeViewController(), animated: true)
    }
}

