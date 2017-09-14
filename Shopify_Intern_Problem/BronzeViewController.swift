//
//  ViewController.swift
//  Shopify_Intern_Problem
//
//  Created by Branden Lee on 9/12/17.
//  Copyright © 2017 Panda Life. All rights reserved.
//

import UIKit

class BronzeViewController: UIViewController {
    
    let name = UILabel()
    let total_spent = UILabel()
    
    var total_sold = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGreen()
        
        setup_navigation()
        setup_constraints()
        setup_ui()
        parse_json_napoleon()
    }
    
    func setup_navigation() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
        self.navigationController?.navigationBar.tintColor = UIColor.cloud()
        
        let title_label = UILabel(frame: CGRect(x:0, y:0, width: UIScreen.main.bounds.width * 0.5, height: 40))
        title_label.text = "Awesome Bronze Bags"
        title_label.textAlignment = .center
        title_label.textColor = UIColor.white
        title_label.font = UIFont(name: "Helvetica-Bold", size: 20)
        self.navigationItem.titleView = title_label
    }
    
    func setup_constraints() {
        name.translatesAutoresizingMaskIntoConstraints = false
        total_spent.translatesAutoresizingMaskIntoConstraints = false
        self.edgesForExtendedLayout = []
        
        self.view.addSubview(name)
        self.view.addSubview(total_spent)
        
        name.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        name.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        name.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        name.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        
        total_spent.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        total_spent.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 50).isActive = true
        total_spent.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        total_spent.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
    }
    
    func setup_ui() {
        name.text = "This is the number of Awesome Bronze Bags"
        name.textAlignment = .center
        name.textColor = UIColor.cloud()
        name.font = UIFont(name: "Helvetica-Bold", size: 30)
        name.lineBreakMode = .byWordWrapping
        name.numberOfLines = 0
        
        total_spent.textAlignment = .center
        total_spent.textColor = UIColor.cloud()
        total_spent.font = UIFont(name: "Helvetica-Bold", size: 30)
        total_spent.lineBreakMode = .byWordWrapping
        total_spent.numberOfLines = 0
    }
    
    /*
     According to https://help.shopify.com/api/reference/order Billing address is optional, customer
     data may or may not exist and shipping address is optional... The only thing not optional is his
     email address so should we use that to identify him?
     
     Currently working under the assumption that we don't know our favorite customer's email
     */
    func parse_json_napoleon() {
        let url: URL = URL(string: "https://shopicruit.myshopify.com/admin/orders.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6")!
        print("entered")
        URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            if (error != nil) {
                self.present_alert(message: error as! String)
                return;
            }
            
            guard let data = data else {
                return;
            }
            
            do {
                let json_info = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                let orders = json_info["orders"] as! Array<AnyObject>
                
                // Process each order
                for order in orders as! [[String:Any]] {
                    // Make sure the order has a total price
                    guard order["line_items"] != nil else {
                        continue;
                    }
                    
                    let line_items = order["line_items"] as! Array<AnyObject>
                    
                    
                    for item in line_items as! [[String:Any]] {
                        if (item["title"] != nil) {
                            let item_name = item["title"] as! String
                            if (item_name.caseInsensitiveCompare("Awesome Bronze Bag") == .orderedSame) {
                                if (item["quantity"] != nil) {
                                    self.total_sold += Int(item["quantity"] as! NSNumber)
                                }
                            }
                        }
                    }
                    
                    print(self.total_sold)
                }
                
                DispatchQueue.main.async {
                    self.total_spent.text = String(self.total_sold) + " Awesome Bronze Bags"
                }
            } catch let error as Error {
                self.present_alert(message: error as! String)
                print(error)
                return;
            }
        }).resume()
    }
    
    func present_alert(message: String) {
        let error_alert = UIAlertController(title: "Error in parsing", message: message, preferredStyle: UIAlertControllerStyle.alert)
        error_alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default))
        self.present(error_alert, animated: true, completion: nil)
    }
}

