//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Joey Newfield on 1/14/18.
//  Copyright © 2018 Joey Newfield. All rights reserved.
//

import UIKit
import Firebase

class SnapsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var snaps : [Snap] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps").observe(DataEventType.childAdded, with: {(snapshot) in
            print(snapshot)
            
            let snap = Snap()
            snap.imageURL = snapshot.value!["imageURL"] as! String
            snap.from = snapshot.value!["from"] as! String
            snap.descrip = snapshot.value!["description"] as! String
            snap.key = snapshot.key
            snap.uuid = snapshot.value!["uuid"] as! String
            
            self.snaps.append(snap)
            
            self.tableView.reloadData()
    })
        
        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps").observe(DataEventType.childRemoved, with: {(snapshot) in
            print(snapshot)
            
            var index = 0
            for snap in self.snaps {
                if snap.key == snapshot.key {
                    self.snaps.remove(at: index)
                }
                index += 1
            }
            self.tableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if snaps.count == 0 {
            return 1
        } else {
            return snaps.count
        }
        return snaps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if snaps.count == 0 {
            cell.textLabel?.text = "You have no snaps ☹️"
        } else {
        
        let snap = snaps[indexPath.row]
        
        cell.textLabel?.text = snap.from
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snap = snaps[indexPath.row]
        
        performSegue(withIdentifier: "viewsnapsegue", sender: snap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "viewsnapsegue" {
        let nextVC = segue.destination as! ViewSnapViewController
        nextVC.snap = sender as! Snap
        }
    }
        
    

    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   
    
}
