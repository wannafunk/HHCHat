//
//  TableViewController.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 14.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    private enum Constants {
        static let heightFooter: CGFloat = 52
        static let heightHeader: CGFloat = 38
    }

    let tableView = UITableView(frame: CGRect.zero, style: .grouped)
    var tableViewDataManager: TableViewDataManager

    init(tableViewDataManager: TableViewDataManager) {
        self.tableViewDataManager = tableViewDataManager

        super.init(nibName: nil, bundle: nil)

        tableView.dataSource = tableViewDataManager
        tableView.delegate = tableViewDataManager
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(model: TableViewModel) {
        tableViewDataManager.model = model
        tableView.reloadData()
    }

    func updateWithModelProcessing(model: TableViewModel) {
        tableViewDataManager.model = model

        if tableView.numberOfSections == 0 {
            tableView.reloadData()
            return
        }

        if isCellVisible(section: getFirstIndexPath().section, row: getFirstIndexPath().row) {
            tableView.beginUpdates()
            insertSectionsIfNeeded(at: model)
            insertRowsIfNeeded(at: model)
            tableView.endUpdates()
        } else {
            let isNewSection = tableView.numberOfSections != model.numberOfSections()
            let newRowsCount = getNewRowsCount(at: model, isNewSection: isNewSection)

            tableView.reloadData()

            let contentOffsetY = getContentOffsetYAfterReload(at: model,
                                                              isNewSection: isNewSection,
                                                              newRowsCount: newRowsCount)

            tableView.setContentOffset(
                CGPoint(x: 0, y: contentOffsetY),
                animated: false
            )

            tableView.layoutIfNeeded()
        }
    }

    func reloadRows(at indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .none)
    }

    func addHeaderTableView(model: TableViewModel) {
        if model.numberOfSections() > 0,
            isCellVisible(section: getFirstIndexPath().section, row: getFirstIndexPath().row) {
            tableView.beginUpdates()
            tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
            tableView.endUpdates()
        }
    }

    func removeHeaderTableView(model: TableViewModel) {
        if model.numberOfSections() > 0 {
            tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
        }
    }

    func indexPathForSelectedRow() -> IndexPath? {
        return tableView.indexPathForSelectedRow
    }

    func selectRow(at indexPath: IndexPath, animated: Bool, scrollPosition: TableViewScrollPosition) {
        tableView.selectRow(at: indexPath, animated: animated, scrollPosition: scrollPosition.uiTableViewScrollPosition)
    }

    func deselectRow(at indexPath: IndexPath, animated: Bool) {
        tableView.deselectRow(at: indexPath, animated: animated)
    }

    func didScrollToBottom() {
        tableView.scrollToRow(at: getFirstIndexPath(), at: .bottom, animated: true)
    }

    // MARK: Utility methods
    private func isCellVisible(section: Int, row: Int) -> Bool {
        let indexPath = IndexPath(row: row, section: section)

        guard let isVisibleCell = tableView.indexPathsForVisibleRows?.contains(indexPath) else {
            return false
        }

        return isVisibleCell
    }

    private func getContentOffsetYAfterReload(at model: TableViewModel,
                                              isNewSection: Bool,
                                              newRowsCount: Int) -> CGFloat {
        var contentOffsetY = tableView.contentOffset.y

        if isNewSection {
            contentOffsetY += Constants.heightFooter
        }

        for index in 0..<newRowsCount {
            if let height = model.modelForCell(at: IndexPath(row: index, section: 0))?.height {
                contentOffsetY += height
            }
        }

        return contentOffsetY
    }

    private func getNewRowsCount(at model: TableViewModel, isNewSection: Bool) -> Int {
        if isNewSection {
            return model.numberOfRows(inSection: 0)
        } else {
            return model.numberOfRows(inSection: 0) - tableView.numberOfRows(inSection: 0)
        }
    }

    private func insertSectionsIfNeeded(at model: TableViewModel) {
        let newSectionsCount = model.numberOfSections() - tableView.numberOfSections

        if newSectionsCount > 0 {
            var count: [Int] = []

            for index in 0..<newSectionsCount {
                count.append(index)
            }

            if !count.isEmpty {
                tableView.insertSections(IndexSet(count), with: .fade)
            }
        }
    }

    private func insertRowsIfNeeded(at model: TableViewModel) {
        var newRowsCount = 0
        var indexPaths: [IndexPath] = []

        if model.numberOfSections() - tableView.numberOfSections > 0 {
            newRowsCount = model.numberOfRows(inSection: 0)
        } else {
            newRowsCount = model.numberOfRows(inSection: 0) - tableView.numberOfRows(inSection: 0)
        }

        if newRowsCount > 0 {
            for index in 0..<newRowsCount {
                indexPaths.append(IndexPath(item: index, section: 0))
            }
        }

        if !indexPaths.isEmpty {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }

    private func getFirstIndexPath() -> IndexPath {
        return IndexPath(row: 0, section: 0)
    }

}
