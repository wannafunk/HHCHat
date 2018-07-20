//
//  ChatViewOutput.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 14.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import Foundation
import UIKit

protocol ChatViewOutput: class {

    func viewDidLoad()

    func onMessageSendButtonTap(with text: String)
    func onFileSendButtonTap(with fileData: Data)
    func onTextViewDidChange(with text: String)
    func onScrollToBottomButtonTap()
    func indexPathsVisibleRows(_ indexPaths: [IndexPath])

    func downloadNextMessages()

}
