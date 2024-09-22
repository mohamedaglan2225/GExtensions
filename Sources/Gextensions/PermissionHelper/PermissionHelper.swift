//
//  File.swift
//  
//
//  Created by Mohamed Aglan on 9/3/24.
//

import Foundation
import Photos
import UIKit

public class PermissionHelper {
    
    public static var topViewController: UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        } else {
            return nil
        }
    }
    
    public static func askForPhotoPermission(completion: ((_ status: Bool) -> Void)? = nil) {
        
        func accessAlert() {
            let alertController = UIAlertController(
                title: NSLocalizedString("صلاحية الوصول", comment: ""),
                message: NSLocalizedString("صلاحية الوصول إلى ألبوم الصور غير مفعلة ، فضلاً السماح بالوصول لألبوم الصور من الإعدادات", comment: ""),
                preferredStyle: .alert
            )
            let okAction = UIAlertAction(title: NSLocalizedString("موافق", comment: ""), style: .default) { _ in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    DispatchQueue.main.async {
                        completion?(false)
                    }
                    return
                }
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl) { success in
                        print("Settings opened: \(success)")
                    }
                } else {
                    DispatchQueue.main.async {
                        completion?(false)
                    }
                }
            }
            let cancelAction = UIAlertAction(title: NSLocalizedString("إلغاء", comment: ""), style: .default)
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            DispatchQueue.main.async {
                if let topViewController = self.topViewController {
                    topViewController.present(alertController, animated: true)
                }
            }
        }
        
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized {
                    DispatchQueue.main.async {
                        completion?(true)
                    }
                } else {
                    if #available(iOS 14, *) {
                        if status == .limited {
                            DispatchQueue.main.async {
                                completion?(true)
                            }
                        } else {
                            DispatchQueue.main.async {
                                completion?(false)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion?(false)
                        }
                    }
                }
            }
        } else {
            if #available(iOS 14, *) {
                if photos == .authorized || photos == .limited {
                    DispatchQueue.main.async {
                        completion?(true)
                    }
                } else {
                    accessAlert()
                }
            } else {
                if photos == .authorized {
                    DispatchQueue.main.async {
                        completion?(true)
                    }
                } else {
                    accessAlert()
                }
            }
        }
    }
}

