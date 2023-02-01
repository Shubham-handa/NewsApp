//
//  Utility.swift
//  NewApp
//
//  Created by Shubham Handa on 21/12/22.
//

import Foundation

func findTime(_ publishedAt: String) -> String {
    var resultedTime = ""
   
    let mytime = Date()
    resultedTime = formatDateAndGetResult(publishedAt, mytime)
    
   
    //debugPrint(resultedTime)
    
    return resultedTime
}

func formatDateAndGetResult(_ value: String,_ currentTime: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    
    let parsedPublishedDateIntoDataObject = dateFormatter.date(from: value)
    
    dateFormatter.dateFormat = "HH"
    dateFormatter.timeZone = TimeZone(identifier: "UTC")
    
    var resultedPublishedDateHours = ""
    
    if let publishedDate = parsedPublishedDateIntoDataObject {
        resultedPublishedDateHours = dateFormatter.string(from: publishedDate)
    }
    
    //dateFormatter.dateFormat = "HH"
    let resultedCurrentDateHours = dateFormatter.string(from: currentTime)
    
    
    
    return finalResult(changeToInt(resultedPublishedDateHours), changeToInt(resultedCurrentDateHours))
}

func changeToInt(_ value: String) -> Int {
    guard let hours = Int(value) else {return 0}
    return hours
}

func finalResult(_ v1: Int, _ v2: Int) -> String {
    let final = abs(v1 - v2)
    var resultedTime = ""
   
    
    if final > 23 {
        resultedTime = "Few Days Ago"
    } else if final <= 0 {
        resultedTime = "Few Minutes Ago"
    } else {
        resultedTime = "\(final)h ago"
    }
    return resultedTime
}
