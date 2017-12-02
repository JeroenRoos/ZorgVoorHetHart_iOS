//
//  DateExtension.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 02/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

extension Date
{
    func getCurrentWeekdayAndDate() -> String?
    {
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        let weekDay = (Date().dayOfWeek()!)
        let currentDate = weekDay + ", " + String(day) + " " + String(month) + " " + String(year)
        return currentDate
    }
    
    private func dayOfWeek() -> String?
    {
        let weekdays = [
            "Zondag",
            "Maandag",
            "Dinsdag",
            "Woensdag",
            "Donderdag",
            "Vrijdag",
            "Zaterdag,"
        ]
        
        let dayNumber = Calendar.current.dateComponents([.weekday], from: self).weekday
        let dayString = weekdays[dayNumber! - 1]
        return dayString[0 ..< 2]
    }
    
    
    /*
    private func dayOfWeek() -> String?
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let weekDay = dateFormatter.string(from: self).capitalized
        return weekDay[0 ..< 2]
    } */
}
