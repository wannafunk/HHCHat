//
//  UIViewController.swift
//  HeadHunterChat
//
//  Created by 12345 on 21.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit

extension UIViewController {

    var navigationBar: UINavigationBar? {
        return navigationController?.navigationBar
    }

    func setNavigationTitle(by title: String) {
        navigationItem.title = title
        navigationBar?.titleTextAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17,
                                                                                            weight: .semibold)]
    }

    func setRightButtonItemWithImage(by image: UIImage) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image:
             image.withRenderingMode(UIImageRenderingMode.alwaysOriginal),
                                                            style: UIBarButtonItemStyle.plain,
                                                            target: nil,
                                                            action: nil)
        navigationItem.rightBarButtonItem?.isEnabled = false
    }

    static func alertRequestPermissionSettings(_ title: String) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: TextConstants.сancelAlert, style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: TextConstants.settingsAlert, style: .default, handler: { (_) -> Void in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.canOpenURL(url as URL)
            }
        }))

        topMostController?.present(alert, animated: true, completion: nil)
    }

    static var topMostController: UIViewController? {
        var topMostController = UIApplication.shared.keyWindow?.rootViewController

        while topMostController?.presentedViewController != nil {
            topMostController = topMostController?.presentedViewController
        }

        return topMostController
    }

}
