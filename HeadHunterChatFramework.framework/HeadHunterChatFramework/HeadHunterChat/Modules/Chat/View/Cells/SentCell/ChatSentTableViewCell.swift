//
//  ChatSentTableViewCell.swift
//  HeadHunterChat
//
//  Created by 12345 on 19.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit

final class ChatSentTableViewCell: UITableViewCell {

    private enum Constants {
        enum Margin {
            //BubbleView
            static let leadingBubbleView: CGFloat = 77
            static let trailingBubbleView: CGFloat = -20
            static let topBubbleView: CGFloat =  5

            //MessageLabel
            static let leadingMessageLabel: CGFloat = 12
            static let trailingMessageLabel: CGFloat = -12
            static let topMessageLabel: CGFloat =  8
            static let bottomMessageLabel: CGFloat = -8
            static let heightMessageLabel: CGFloat = 20

            //TimeLabel
            static let topTimeLabel: CGFloat =  8
            static let bottomTimeLabel: CGFloat = -5
            static let heightTimeLabel: CGFloat = 14.5

            //ActivityIndicator
            static let heightActivityIndicator: CGFloat = 10
            static let widthActivityIndicator: CGFloat = 10
            static let scaleFactorActivityIndicator: CGFloat = 0.6
        }
    }

    private let bubbleView = ChatSentView()
    private let messageLabel = UILabel()
    private let timeLabel = UILabel()
    private let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)

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

        contentView.addSubview(bubbleView)
        contentView.addSubview(messageLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(activityIndicator)

        setupBubleView()
        setupMessageLabel()
        setupTimeLabel()
        setupActivityIndicator()
    }

    private func setupBubleView() {
        bubbleView.translatesAutoresizingMaskIntoConstraints = false

        bubbleView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor,
                                            constant: Constants.Margin.leadingBubbleView).isActive = true
        bubbleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                             constant: Constants.Margin.trailingBubbleView).isActive = true
        bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                        constant: Constants.Margin.topBubbleView).isActive = true
    }

    private func setupMessageLabel() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        messageLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor,
                                              constant: Constants.Margin.leadingMessageLabel).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor,
                                               constant: Constants.Margin.trailingMessageLabel).isActive = true
        messageLabel.topAnchor.constraint(equalTo: bubbleView.topAnchor,
                                          constant: Constants.Margin.topMessageLabel).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor,
                                             constant: Constants.Margin.bottomMessageLabel).isActive = true
    }

    private func setupTimeLabel() {
        timeLabel.translatesAutoresizingMaskIntoConstraints = false

        timeLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor).isActive = true
        timeLabel.topAnchor.constraint(equalTo: bubbleView.bottomAnchor,
                                       constant: Constants.Margin.topTimeLabel).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                          constant: Constants.Margin.bottomTimeLabel).isActive = true
    }

    private func setupActivityIndicator() {
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.scale(factor: Constants.Margin.scaleFactorActivityIndicator)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor).isActive = true
        activityIndicator.trailingAnchor.constraint(equalTo: timeLabel.trailingAnchor).isActive = true
    }

    private func configureTextMessage(with text: String) {
        messageLabel.setStyle(with: text, style: TextStyle.SentMessageStyle.Label.textStyle)
    }

    private func configureTime(with date: Date) {
        timeLabel.setStyle(with: date, style: TextStyle.SentMessageStyle.Label.dateStyle)
    }

    private func configureFromStatusMessage(by status: HHMessageSendStatus) {
        switch status {
        case .sent:
            hideLoader()
            timeLabel.isHidden = false
        case .sending:
            showLoader()
            timeLabel.isHidden = true
        }
    }

    private func showLoader() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }

    private func hideLoader() {
        self.activityIndicator.stopAnimating()
    }

    private static func getHeightMessageLabel(for text: String, style: TextStyle) -> CGFloat {
        let maxLabelWidth: CGFloat = UIScreen.main.bounds.width -
            Constants.Margin.leadingBubbleView
            + Constants.Margin.trailingBubbleView -
            Constants.Margin.leadingMessageLabel +
            Constants.Margin.trailingMessageLabel

        let label = UILabel()
        label.setStyle(with: text, style: style)
        let neededMessageSize = label.sizeThatFits(CGSize(width: maxLabelWidth,
                                                          height: CGFloat.greatestFiniteMagnitude))
        return neededMessageSize.height
    }

    private static func getHeightTimeLabel(for date: Date, style: TextStyle) -> CGFloat {
        let maxLabelWidth: CGFloat = UIScreen.main.bounds.width -
            Constants.Margin.leadingBubbleView +
            Constants.Margin.trailingBubbleView -
            Constants.Margin.leadingMessageLabel +
            Constants.Margin.trailingMessageLabel

        let label = UILabel()
        label.setStyle(with: date, style: style)
        let neededMessageSize = label.sizeThatFits(CGSize(width: maxLabelWidth,
                                                          height: CGFloat.greatestFiniteMagnitude))
        return neededMessageSize.height
    }

    private static func getAmaountMargings() -> CGFloat {
        let amount = Constants.Margin.topBubbleView +
            Constants.Margin.topMessageLabel +
            -Constants.Margin.bottomMessageLabel +
            Constants.Margin.topTimeLabel +
            -Constants.Margin.bottomTimeLabel
        return amount
    }

}

// MARK: - BaseTableViewCell
extension ChatSentTableViewCell: BaseTableViewCell {

    static func heightFor(width: CGFloat, model: TableViewCellModel?) -> CGFloat {
        guard let model = model as? ChatTableViewCellModel else {
            return 0
        }

        let messageLabelHeight = getHeightMessageLabel(for: model.message.messageText,
                                                       style: TextStyle.SentMessageStyle.Label.textStyle)
        let timeLabelHeight = getHeightTimeLabel(for: model.message.messageTime,
                                                 style: TextStyle.SentMessageStyle.Label.dateStyle)

        model.height = messageLabelHeight + timeLabelHeight + getAmaountMargings()

        return model.height
    }

    func update(with model: TableViewCellModel?) {
        guard let model = model as? ChatTableViewCellModel else {
                return
        }

        configureTextMessage(with: model.message.messageText)
        configureTime(with: model.message.messageTime)

        configureFromStatusMessage(by: model.message.sendStatus)
    }

}
