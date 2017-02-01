//
//  Util.swift
//  Reservation
//
//  Created by Kiranpal Reddy Gurijala on 1/29/17.
//  Copyright © 2017 AryaVahni. All rights reserved.
//

import UIKit

class Util: NSObject {

    static let M_NAME = "MassageName"
    static let M_DESC = "MassageDescription"
    static let M_DURA = "MassageDuration"
    static let M_STIME = "SelectedTime"
    static let M_SDATE = "SelectedDate"
    static let M_PSIZE = "PartySize"
    
    //MARK: Get the list of saved reservations from plist
    class func getReservations() ->  [Reservation] {
        
        let fileMgr = FileManager.default
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let tmpPath:NSString = paths[0] as NSString
        let docPath = tmpPath .appendingPathComponent("Reservation.plist")
        var rlist = [Reservation]()
        if(fileMgr.fileExists(atPath: docPath)){
            let list = NSArray(contentsOfFile: docPath)!
            for d in list {
                let dict = d as! [String:String]
                let r = Reservation()
                r.massageName = dict[M_NAME]
                r.massageDesc = dict[M_DESC]
                r.massageDuration = dict[M_DURA]
                r.time = dict[M_STIME]
                r.date = dict[M_SDATE]
                r.partySize = dict[M_PSIZE]
                rlist.append(r)
            }
        }         
        return rlist
    }
    //MARK: Save the reservations onto the plist file
    class func addReservation(reservation:Reservation)
    {
        let newEntry = [M_NAME:reservation.massageName,M_DESC:reservation.massageDesc,M_DURA:reservation.massageDuration,M_PSIZE:reservation.partySize,M_SDATE:reservation.date,M_STIME:reservation.time]
        let fileMgr = FileManager.default
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let tmpPath:NSString = paths[0] as NSString
        let docPath = tmpPath .appendingPathComponent("Reservation.plist")
        if(fileMgr.fileExists(atPath: docPath)){
            
            
            let list = NSArray(contentsOfFile: docPath)!
            let newlist = NSMutableArray()
            newlist.addObjects(from: list as! [Any])
            newlist.add(newEntry)
            newlist.write(toFile: docPath, atomically: true)
        }else {
            let newlist:NSArray = [newEntry]
            newlist.write(toFile: docPath, atomically: true)
        }
    }
}
