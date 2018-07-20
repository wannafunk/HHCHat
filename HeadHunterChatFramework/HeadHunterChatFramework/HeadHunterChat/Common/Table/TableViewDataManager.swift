//
//  TableViewDataManager.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 14.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit

final class TableViewDataManager: NSObject {

    var model: TableViewModel?

    private weak var delegate: TableViewDataManagerDelegate?
    weak var scrollViewDelegate: UIScrollViewDelegate?

    required init(delegate: TableViewDataManagerDelegate?) {
        self.delegate = delegate
    }

    func updateCell(_ cell: UITableViewCell, atIndexPath indexPath: IndexPath) {
        if let cell = cell as? BaseTableViewCell {
            cell.update(with: model?.modelForCell(at: indexPath))
        }
    }

}

extension TableViewDataManager: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        guard let model = model else {
            return 0
        }

        return model.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = model else {
            return 0
        }

        return model.numberOfRows(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellModel = model?.modelForCell(at: indexPath) else {
            return UITableViewCell()
        }

        var cell = tableView.dequeueReusableCell(withIdentifier: cellModel.cellReuseIdentifier)

        if cell == nil {
            tableView.register(cellModel.cellClass, forCellReuseIdentifier: cellModel.cellReuseIdentifier)
            cell = tableView.dequeueReusableCell(withIdentifier: cellModel.cellReuseIdentifier)
        }
        if let cell = cell as? BaseTableViewCell {
            cell.update(with: cellModel)
        }

        cell?.transform = tableView.transform
        cell?.selectionStyle = .none

        return cell ?? UITableViewCell()
    }

}

extension TableViewDataManager: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cellModel = model?.modelForCell(at: indexPath) else {
            return CGFloat.leastNormalMagnitude
        }
        return cellModel.cellClass.heightFor(width: tableView.bounds.width, model: cellModel)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let headerModel = model?.modelForHeader(inSection: section) else {
            return CGFloat.leastNormalMagnitude
        }
        return headerModel.headerFooterClass.height(withWidth: tableView.bounds.width, model: headerModel)
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let footerModel = model?.modelForFooter(inSection: section) else {
            return CGFloat.leastNormalMagnitude
        }

        return footerModel.headerFooterClass.height(withWidth: tableView.bounds.width, model: footerModel)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerModel = model?.modelForHeader(inSection: section) else {
            return nil
        }

        var header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerModel.headerFooterReuseIdentifier)

        if header == nil {
            tableView.register(headerModel.headerFooterClass,
                               forHeaderFooterViewReuseIdentifier: headerModel.headerFooterReuseIdentifier)
            header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerModel.headerFooterReuseIdentifier)
        }

        if let header = header as? BaseTableViewHeaderFooterView {
            header.update(model: headerModel)
        }

        header?.transform = tableView.transform

        return header
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerModel = model?.modelForFooter(inSection: section) else {
            return nil
        }

        var footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: footerModel.headerFooterReuseIdentifier)

        if footer == nil {
            tableView.register(footerModel.headerFooterClass,
                               forHeaderFooterViewReuseIdentifier: footerModel.headerFooterReuseIdentifier)
            footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: footerModel.headerFooterReuseIdentifier)
        }

        if let footer = footer as? BaseTableViewHeaderFooterView {
            footer.update(model: footerModel)
        }

        footer?.transform = tableView.transform

        return footer
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        delegate?.willDisplayCell(at: indexPath)
    }

    func tableView(_ tableView: UITableView,
                   didEndDisplaying cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        delegate?.didEndDisplayingCell(at: indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectRowAt(tableView, didSelectRowAt: indexPath)
    }

    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewDidScroll?(scrollView)
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewDidZoom?(scrollView)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewWillBeginDragging?(scrollView)
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        scrollViewDelegate?.scrollViewWillEndDragging?(scrollView,
                                                       withVelocity: velocity,
                                                       targetContentOffset: targetContentOffset)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollViewDelegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewWillBeginDecelerating?(scrollView)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewDidEndDecelerating?(scrollView)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewDidEndScrollingAnimation?(scrollView)
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scrollViewDelegate?.viewForZooming?(in: scrollView)
    }

    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        scrollViewDelegate?.scrollViewWillBeginZooming?(scrollView, with: view)
    }

    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        scrollViewDelegate?.scrollViewDidEndZooming?(scrollView, with: view, atScale: scale)
    }

    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        return scrollViewDelegate?.scrollViewShouldScrollToTop?(scrollView) ?? true
    }

    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewDidScrollToTop?(scrollView)
    }

}
