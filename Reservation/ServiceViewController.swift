//
//  ServiceViewController.swift
//  Reservation
//
//  Created by Kiranpal Reddy Gurijala on 1/28/17.
//  Copyright © 2017 AryaVahni. All rights reserved.
//

import UIKit

class ServiceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var MassageServiceListTable: UITableView!
    
    let serviceList:[String] = ["Swedish Massage", "Deep Tissue Massage", "Hot Stone Massage", "Reflexology", "Trigger Point Therapy"]
    
    //MARK: - View controller life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //for rounded corners
        MassageServiceListTable.layer.cornerRadius = 10
        MassageServiceListTable.layer.masksToBounds = true
        
    }

    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return serviceList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceName", for: indexPath)
        
        // Configure the cell...
        
        cell.textLabel?.text = serviceList[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Helvetica Neue", size:12);
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
