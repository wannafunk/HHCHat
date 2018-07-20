//
//  ChatViewInput.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 14.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import Foundation
import UIKit

protocol ChatViewInput: TableViewControllerInput {

    func showLoader()
    func hideLoader()
    func removeSpinnerForTableView()
    func showAlert(title: String, message: String, buttonTitle: String, onDismiss: ((UIAlertAction) -> Void)?)
    func showOpenPhoto(for fileImage: UIImage)
    func updateBubbleCountView(for count: Int)

    func setScrollViewDelegate()

}
