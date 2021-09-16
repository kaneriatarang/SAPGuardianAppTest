//
//  NotificationCenter+Extension.swift
//  SAPGuardianApp
//
//  Created by Tarang Kaneriya on 15/09/21.
//

import Foundation

extension NotificationCenter {
    // We shoude Avoid adding multipule Notification observer
    func setObserver(_ observer: AnyObject, selector: Selector, name: NSNotification.Name, object: AnyObject?) {
        NotificationCenter.default.removeObserver(observer, name: name, object: object)
        NotificationCenter.default.addObserver(observer, selector: selector, name: name, object: object)
    }
}
