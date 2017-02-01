//
//  MyReservationsViewController.swift
//  Reservation
//
//  Created by Kiranpal Reddy Gurijala on 1/29/17.
//  Copyright © 2017 AryaVahni. All rights reserved.
//

import UIKit

class MyReservationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Table view properties
    @IBOutlet weak var tableView: UITableView!
    var reservationTableCell = ReservationTableCell()
    
    var rlist:[Reservation] = [Reservation]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.setLeftBarButton(nil, animated: true)
        rlist = Util.getReservations();
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showList(_ sender: Any) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MassageList") as? MassageListViewController {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: false)
            }
        }
    }
    
    // MARK: - Table view data source
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return rlist.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        reservationTableCell = tableView.dequeueReusableCell(withIdentifier: ReservationTableCell.tableCellId(), for: indexPath) as! ReservationTableCell
        // Configure the cell...
        
        reservationTableCell.textLabel?.font = UIFont(name: "Helvetica Neue", size:12);
        
        //Loading the saved reservations from the plist file
        
        reservationTableCell.reservationDay.text = rlist[indexPath.section].date
        reservationTableCell.reservationTime.text = rlist[indexPath.section].time
        reservationTableCell.reservedServiceName.text = rlist[indexPath.section].massageName
        reservationTableCell.reservationPartySize.text = "PARTY SIZE - "+rlist[indexPath.section].partySize
        reservationTableCell.reservedServiceDuration.text = rlist[indexPath.section].massageDuration
        reservationTableCell.reservedServiceDescription.text = rlist[indexPath.section].massageDesc
        
        return reservationTableCell
    }


}
// Class for custom Cell
class ReservationTableCell: UITableViewCell {
    
    // MARK: - Custom Cell Class Properties
    @IBOutlet weak var reservationDay: UILabel!
    @IBOutlet weak var reservationTime: UILabel!
    @IBOutlet weak var reservedServiceName: UILabel!
    @IBOutlet weak var reservationPartySize: UILabel!
    @IBOutlet weak var reservedServiceDuration: UILabel!
    @IBOutlet weak var reservedServiceDescription: UITextView!
    
    // MARK: - Custom Cell Class methods
    class func tableCellId() -> String {
        return "ReservationCell"
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.reservationDay.text = ""
        reservationTime.text = ""
        reservedServiceName.text = ""
        reservationPartySize.text = ""
        reservedServiceDuration.text = ""
        reservedServiceDescription.text = ""
    }
}
