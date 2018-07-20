//
//  TableViewControllerInput.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 14.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import Foundation
import UIKit

protocol TableViewControllerInput: class {

    func update(model: TableViewModel)
    func updateWithModelProcessing(model: TableViewModel)
    func reloadRows(at indexPath: IndexPath)
    func addHeaderTableView(model: TableViewModel)
    func removeHeaderTableView(model: TableViewModel)
    func indexPathForSelectedRow() -> IndexPath?
    func selectRow(at indexPath: IndexPath, animated: Bool, scrollPosition: TableViewScrollPosition)
    func deselectRow(at indexPath: IndexPath, animated: Bool)
    func didScrollToBottom()

}
