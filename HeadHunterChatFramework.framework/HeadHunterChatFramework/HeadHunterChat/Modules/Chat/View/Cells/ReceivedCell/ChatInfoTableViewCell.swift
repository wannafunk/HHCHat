//
//  ChatInfoTableViewCell.swift
//  HeadHunterChat
//
//  Created by 12345 on 21.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit

final class ChatInfoTableViewCell: UITableViewCell {

    private enum Constants {
        enum Margin {
            static let leadingInfoLabel: CGFloat = 40
            static let trailingInfoLabel: CGFloat = -40
            static let topInfoLabel: CGFloat =  12
            static let bottomInfoLabel: CGFloat = -12
        }
    }

    private let infoLabel = UILabel()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setup()
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    // MARK: - Utility Methods
    private func setup() {
        backgroundColor = .clear

        contentView.addSubview(infoLabel)

        setupInfoLabel()
    }

    private func setupInfoLabel() {
        infoLabel.translatesAutoresizingMaskIntoConstraints = false

        infoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                           constant: Constants.Margin.leadingInfoLabel).isActive = true
        infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                            constant: Constants.Margin.trailingInfoLabel).isActive = true
        infoLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                       constant: Constants.Margin.topInfoLabel).isActive = true
        infoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                          constant: Constants.Margin.bottomInfoLabel).isActive = true
    }

    private static func getAmaountMargings() -> CGFloat {
        let amount = Constants.Margin.topInfoLabel + -Constants.Margin.bottomInfoLabel
        return amount
    }

}

// MARK: - BaseTableViewCell
extension ChatInfoTableViewCell: BaseTableViewCell {

    static func heightFor(width: CGFloat, model: TableViewCellModel?) -> CGFloat {
        guard let model = model as? ChatTableViewCellModel else {
            return 0
        }

        let maxLabelWidth: CGFloat = UIScreen.main.bounds.width - Constants.Margin.leadingInfoLabel +
            Constants.Margin.trailingInfoLabel

        let label = UILabel()
        label.setStyle(with: model.message.messageText, style: TextStyle.InfoMessageStyle.Label.textStyle)
        let neededSize = label.sizeThatFits(CGSize(width: maxLabelWidth, height: CGFloat.greatestFiniteMagnitude))
        let labelHeight = neededSize.height
        return labelHeight + getAmaountMargings()
    }

    func update(with model: TableViewCellModel?) {
        guard let model = model as? ChatTableViewCellModel else {
                return
        }

        infoLabel.setStyle(with: model.message.messageText, style: TextStyle.InfoMessageStyle.Label.textStyle)
    }

}
