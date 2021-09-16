//
//  DateManager.swift
//  SAPGuardianApp
//
//  Created by Tarang Kaneriya on 16/09/21.
//

import Foundation

class DateManager {
    
    //MARK:- Converts "yyyy-MM-dd'T'HH:mm:ssZ"/"2021-08-15T16:31:09Z" string to 1 Day ago formate respective to current date and time.
    class func formateDate(webDate:String?) -> String? {
        
        guard let dateString = webDate else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: dateString) else { return nil }
        
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        let string = formatter.localizedString(for: date, relativeTo: Date())
        
        return string
    }
    
}
