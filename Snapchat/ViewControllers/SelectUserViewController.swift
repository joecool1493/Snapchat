//
//  SelectUserViewController.swift
//  Snapchat
//
//  Created by Joey Newfield on 1/16/18.
//  Copyright © 2018 Joey Newfield. All rights reserved.
//

import UIKit
import Firebase

class SelectUserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var users : [User] = []
    
    var imageURL = ""
    var descrip = ""
    var uuid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        Database.database().reference().child("users").observe(DataEventType.childAdded, with: {(snapshot) in
            print(snapshot)
            
            let user = User()
            user.email = (snapshot.value! as! AnyObject)["email"] as! String
            user.uid = snapshot.key
            
            self.users.append(user)
            
            self.tableView.reloadData()
        })
        }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.email
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        
        let snap = ["from":Auth.auth()!.currentUser!.email!, "description":descrip, "imageURL":imageURL, "uuid":uuid]
        
        Database.database().reference().child("users").child("snaps").child("snaps").childByAutoId().setValue(snap)
        
        navigationController!.popToRootViewController(animated: true)
    }

}
