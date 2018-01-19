//
//  DateExtension.swift
//  554052_ZorgVoorHetHart
//
//  Created by Jeroen on 02/12/2017.
//  Copyright © 2017 Jeroen Roos. All rights reserved.
//

import UIKit

// Extension of Date which gives me the current date in the correct format needed during a new measurement
extension Date
{
    func getDateInCorrectFormat(myDate: String) -> String?
    {
        let dateAndTimeArray = myDate.split(separator: "T")
        let dateArray = dateAndTimeArray[0].split(separator: "-")
        let year = dateArray[0]
        let month = Date().getMonthOfYear(monthInt: Int(dateArray[1])!, fullString: false)
        let day = dateArray[2]
        var currentDate = String(day) + " "
        currentDate += month! + " " + String(year)
        return currentDate
    }
    
    func getCurrentWeekdayAndDate() -> String?
    {
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = (Date().getMonthOfYear(monthInt: calendar.component(.month, from: date), fullString: true)!)
        let year = calendar.component(.year, from: date)
        let weekDay = (Date().getDayOfWeek()!)
        
        let currentDate = weekDay + ", " + String(day) + " " + month + " " + String(year)
        return currentDate
    }
    
    private func getMonthOfYear(monthInt: Int, fullString: Bool) -> String?
    {
        let months = [
            "januari",
            "februari",
            "maart",
            "april",
            "mei",
            "juni",
            "juli",
            "augustus",
            "september",
            "oktober",
            "november",
            "december"
        ]
        
        if (fullString)
        {
            return months[monthInt - 1]
        }
        else
        {
            let month = months[monthInt - 1]
            return month[0 ..< 3]
        }
    }
    
    private func getDayOfWeek() -> String?
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
}
