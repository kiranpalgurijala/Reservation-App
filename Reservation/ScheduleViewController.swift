//
//  ScheduleViewController.swift
//  Reservation
//
//  Created by Kiranpal Reddy Gurijala on 1/29/17.
//  Copyright © 2017 AryaVahni. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController,CGCalendarViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIPickerViewDataSource, UIPickerViewDelegate {


    
    @IBOutlet weak var month: UILabel!
    var sizePicker: UIPickerView!
    var toolBar:UIToolbar!

    @IBOutlet var calendarView: CGCalendarView!
    @IBOutlet weak var partySize: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
   
    var calendar:Calendar!
    var light_Blue:UIColor {
        return UIColor(red:(156.0/255.0),green:(191.0/255.0),blue:(230.0/255.0), alpha:1.0)
    }
    
    let timeSlots = ["09:00 AM","10:00 AM","11:00 AM","12:00 PM","01:00 PM","02:00 PM","03:00 PM","04:00 PM","05:00 PM","06:00 PM","07:00 PM","08:00 PM"]
    
    
    var selectedDate:Date!
    var selectedTime:String!
    var selectedDateStr:String!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        calendarView.calendar = calendar
        calendarView.backgroundColor = UIColor.white
        calendarView.rowCellClass = CGCalendarCell.self
        calendarView.firstDate = Date().addingTimeInterval(-60*60*24*30);
        calendarView.lastDate = Date().addingTimeInterval(60*60*24*180)
        calendarView.delegate = self;
        
        sizePicker = UIPickerView()
        sizePicker.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 220)
        sizePicker.delegate = self
        sizePicker.dataSource = self
        
        toolBar = UIToolbar()
        toolBar.frame = CGRect(x:0,y:0, width:self.view.frame.width, height:44)
        toolBar.sizeToFit()
        
        let button:UIButton = UIButton(frame: CGRect(x:0,y:0,width:100,height:25))
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(self.doneClicked), for: UIControlEvents.touchUpInside)
        let done:UIBarButtonItem = UIBarButtonItem(customView: button)
        
        let space:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let btn2:UIButton = UIButton(frame: CGRect(x:120,y:0,width:100,height:25))
        btn2.setTitle("Cancel", for: .normal)
        btn2.setTitleColor(UIColor.darkGray, for: .normal)
        btn2.addTarget(self, action: #selector(self.cancelClicked), for: UIControlEvents.touchUpInside)
        let cancel:UIBarButtonItem = UIBarButtonItem(customView: btn2)
        toolBar.items=[cancel,space,done];
        partySize.inputView = sizePicker
        partySize.inputAccessoryView = toolBar
        
        
    }
    
    func doneClicked() {
        partySize.resignFirstResponder()
    }
    func cancelClicked(){
        
        partySize.text = String(0)
        partySize.resignFirstResponder()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Collection view delegate methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return timeSlots.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cellIdentifier:String = "timeCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath as IndexPath)
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1.0
        let title:UILabel = cell.viewWithTag(10) as! UILabel
        title.text = timeSlots[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let  cell = collectionView.cellForItem(at: indexPath)
        cell?.contentView.backgroundColor = light_Blue
        cell?.viewWithTag(20)?.isHidden = false
        
        selectedTime = timeSlots[indexPath.item]
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath)
    {
        let  cell = collectionView.cellForItem(at: indexPath)
        cell?.contentView.backgroundColor = UIColor.white
        cell?.viewWithTag(20)?.isHidden = true
    }
    
    func calendarView(_ calendarView: CGCalendarView!, didSelect date: Date!) {
        selectedDate = (date as NSDate!) as Date!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        month.text = formatter.string(from: date).uppercased()
        formatter.dateFormat = "EEEE, MMMM d,yyyy"
            selectedDateStr = formatter.string(from: date)
    }
    
    //MARK: - Picker view delegate methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return 12
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return String(row+1)
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        partySize.text = String(row+1)
    }
    @IBAction func reserveClicked(_ sender: Any) {
        
        var error = "", title = "Error";
        if(selectedDate == nil){
            error = "No Date Selected";
        }else if(selectedTime == nil || selectedTime == ""){
            error = "No Time Selected"
        }else if(partySize.text == "" || Int(partySize.text!) == 0){
            error = "Invalid Party Size"
        }else {
            
            let r = Reservation()
            r.massageName = "Hot Stone Massage"
            r.massageDesc = "Massage focused on the deepest layer of muscles to target knots and release chronic muscle tension."
            r.massageDuration = "2H"
            r.date = selectedDateStr
            r.time = selectedTime
            r.partySize = partySize.text
            Util.addReservation(reservation: r)
            error = "Reservation added!"
            title = "Success"
        }
        if (error != ""){
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReservationsList") as? MyReservationsViewController {
                if let navigator = navigationController {
                    navigator.pushViewController(viewController, animated: false)
                }
            }
            /*else{
                let alert = UIAlertController(title:title,message:error,preferredStyle:.alert)
                let ok = UIAlertAction(title:"Ok",style:.default,handler:nil)
                alert.addAction(ok)
                present(alert, animated: true, completion: nil)
            }*/
        }
    }
    

}
