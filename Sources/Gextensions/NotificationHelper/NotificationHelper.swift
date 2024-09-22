//
//  File.swift
//  
//
//  Created by Mohamed Aglan on 9/3/24.
//

import Foundation
import UIKit

public class NotificationHelper {
    
    public static func presentNotificationForDownload(_ notifAction: String, notifBody: String) {
        DispatchQueue.main.async {
            let application = UIApplication.shared
            let applicationState = application.applicationState
            
            if applicationState == .background {
                let localNotification = UILocalNotification()
                localNotification.alertBody = notifBody
                localNotification.alertAction = notifAction
                localNotification.soundName = UILocalNotificationDefaultSoundName
                localNotification.applicationIconBadgeNumber += 1
                application.presentLocalNotificationNow(localNotification)
            }
        }
    }
}

