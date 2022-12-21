//
//  Utility.swift
//  NewApp
//
//  Created by Shubham Handa on 21/12/22.
//

import Foundation

func findTime(_ publishedAt: String) -> String {
    var resultedTime = ""
    
    debugPrint("Date new publishedAt \(publishedAt)")
    //Date Foramting of publishedDate of News coming from api
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    let result = dateFormatter.date(from: publishedAt)
    dateFormatter.dateFormat = "HH"
    dateFormatter.timeZone = TimeZone(identifier: "UTC")
    var publishedTime = ""
    if let str = result {
        publishedTime = dateFormatter.string(from: str)
    }
    
    //Date Formating of current date
    let mytime = Date()
    let currentDateForMatter = DateFormatter()
    print(mytime)
    dateFormatter.dateFormat = "HH"
    let currentResult = dateFormatter.string(from: mytime)
    debugPrint("current Date \(currentResult)")
    
    //Change to int
    var d1 = 0
    if let first = Int(publishedTime) {
        d1 = first
    }
    var d2 = 0
    if let first = Int(currentResult) {
        d2 = first
    }
    let final = abs(d1 - d2)
    debugPrint("Final \(final)")
    
    if final > 23 {
        resultedTime = "1Day"
    }else {
        resultedTime = "\(final)h"
    }
    
    return resultedTime
}
