//
//  TableViewDataManagerDelegate.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 14.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit

protocol TableViewDataManagerDelegate: class {

    func willDisplayCell(at indexPath: IndexPath)
    func didEndDisplayingCell(at indexPath: IndexPath)
    func didSelectRowAt(_ tableView: UITableView, didSelectRowAt: IndexPath)

}

extension TableViewDataManagerDelegate {

    func willDisplayCell(at indexPath: IndexPath) { }
    func didEndDisplayingCell(at indexPath: IndexPath) { }
    func didSelectRowAt(_ tableView: UITableView, didSelectRowAt: IndexPath) { }
}
