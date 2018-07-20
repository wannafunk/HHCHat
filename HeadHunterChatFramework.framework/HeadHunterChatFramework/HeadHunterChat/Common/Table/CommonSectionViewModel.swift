//
//  CommonSectionViewModel.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 14.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import Foundation

final class CommonSectionViewModel<T: TableViewCellModel> {

    var header: TableViewHeaderFooterModel?
    var cells: [T]
    let footer: TableViewHeaderFooterModel?

    init(header: TableViewHeaderFooterModel? = nil,
         cells: [T],
         footer: TableViewHeaderFooterModel? = nil) {
        self.header = header
        self.cells = cells
        self.footer = footer
    }

}
