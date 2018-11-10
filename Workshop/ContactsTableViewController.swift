//
//  ContactsTableViewController.swift
//  Workshop
//
//  Created by Naren kumar Konchada on 09/11/18.
//  Copyright © 2018 Naren kumar Konchada. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController {
    private var contactData = [Dictionary<String, Any>]()
    
    // MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSONData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: method for getting Data
    
    public func getJSONData() {
        if let path = Bundle.main.path(forResource: "Contacts", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let contactsInfo = jsonResult["contacts"] as? [Any] {
                    // Assigning it to our local variable
                    contactData = contactsInfo as! [Dictionary<String, Any>]
                }
            } catch {
                // Handle any errors
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return contactData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //  Cell is the basic component for a tableView
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let contactName = contactData[indexPath.row]["name"] as? String {
            cell.textLabel?.text = contactName
            cell.textLabel?.textColor = UIColor.blue
        }
        if let contactTitle = contactData[indexPath.row]["title"] as? String {
            cell.detailTextLabel?.text = contactTitle
        }
        return cell
    }
    
    // MARK: - Table view Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Alert the user
        let alertController = UIAlertController(title: "Alert", message:
            "Hello, world!", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }

}
