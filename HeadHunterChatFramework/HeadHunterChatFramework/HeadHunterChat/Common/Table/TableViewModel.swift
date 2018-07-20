//
//  TableViewModel.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 14.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import Foundation

protocol TableViewModel {

    func numberOfSections() -> Int
    func numberOfRows(inSection section: Int) -> Int
    func modelForHeader(inSection section: Int) -> TableViewHeaderFooterModel?
    func modelForFooter(inSection section: Int) -> TableViewHeaderFooterModel?
    func modelForCell(at indexPath: IndexPath) -> TableViewCellModel?
    func indexPath(for cellModel: TableViewCellModel) -> IndexPath?

}

extension TableViewModel {

    func numberOfSections() -> Int {
        return 1
    }

    func modelForHeader(inSection section: Int) -> TableViewHeaderFooterModel? {
        return nil
    }

    func modelForFooter(inSection section: Int) -> TableViewHeaderFooterModel? {
        return nil
    }

    func indexPath(for сellModel: TableViewCellModel) -> IndexPath? {
        return nil
    }

}
