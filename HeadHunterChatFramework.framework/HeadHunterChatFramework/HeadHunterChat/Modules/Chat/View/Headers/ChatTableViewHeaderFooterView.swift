//
//  ChatTableViewHeaderFooterView.swift
//  HeadHunterChat
//
//  Created by 12345 on 04.07.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit

class ChatTableViewHeaderFooterView: UITableViewHeaderFooterView {

    private let dateLabel = UILabel()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setup()
    }

    // MARK: - Utility Methods
    private func setup() {
        backgroundColor = .clear

        dateLabel.textColor = .darkGray
        dateLabel.font = dateLabel.font.withSize(14)

        dateLabel.translatesAutoresizingMaskIntoConstraints = false

        dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    private func setTime(by date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateLabel.text = dateFormatter.string(from: date)
    }

}

// MARK: - BaseTableViewHeaderFooterView
extension ChatTableViewHeaderFooterView: BaseTableViewHeaderFooterView {
    static func height(withWidth width: CGFloat, model: TableViewHeaderFooterModel?) -> CGFloat {
        return 20
    }

    func update(model: TableViewHeaderFooterModel?) {
        guard let model = model as? ChatHeaderTableViewCellModel else {
            return
        }

        setTime(by: model.date)
    }

}
