//
//  ChatReceivedFileTableViewCell.swift
//  HeadHunterChat
//
//  Created by 12345 on 27.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit

final class ChatReceivedFileTableViewCell: UITableViewCell {

    private enum Constants {
        static let cornerRadius: CGFloat = 8

        enum Margin {
            //BubbleView
            static let leadingBubbleView: CGFloat = 20
            static let topBubbleView: CGFloat =  5

            //FileImageView
            static let heightFileImageView: CGFloat = 164
            static let widthFileImageView: CGFloat = 164

            //TimeLabel
            static let topTimeLabel: CGFloat =  8
            static let bottomTimeLabel: CGFloat = -5

            //ContentView
            static let heightContentView: CGFloat = 197
        }
    }

    private let bubbleView = ChatReceivedView()
    private var fileImageView = UIImageView()
    private let timeLabel = UILabel()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setup()
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        fileImageView.image = nil
        sd_cancelCurrentImageLoad()
    }

    // MARK: - Utility Methods
    private func setup() {
        backgroundColor = .clear

        contentView.addSubview(bubbleView)
        contentView.addSubview(fileImageView)
        contentView.addSubview(timeLabel)

        setupFileImageView()
        setupBubleView()
        setupTimeLabel()
    }

    private func setupBubleView() {
        bubbleView.backgroundColor = AppStyle.Color.mainLightGray
        bubbleView.layer.cornerRadius = Constants.cornerRadius
        bubbleView.layer.masksToBounds = true

        bubbleView.translatesAutoresizingMaskIntoConstraints = false

        bubbleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                            constant: Constants.Margin.leadingBubbleView).isActive = true
        bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                        constant: Constants.Margin.topBubbleView).isActive = true
    }

    private func setupFileImageView() {
        fileImageView.layer.cornerRadius = Constants.cornerRadius
        fileImageView.layer.masksToBounds = true
        fileImageView.clipsToBounds = true
        fileImageView.contentMode = .scaleAspectFill

        fileImageView.translatesAutoresizingMaskIntoConstraints = false

        fileImageView.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor).isActive = true
        fileImageView.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor).isActive = true
        fileImageView.topAnchor.constraint(equalTo: bubbleView.topAnchor).isActive = true
        fileImageView.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor).isActive = true
        fileImageView.heightAnchor.constraint(equalToConstant: Constants.Margin.heightFileImageView).isActive = true
        fileImageView.widthAnchor.constraint(equalToConstant: Constants.Margin.widthFileImageView).isActive = true
    }

    private func setupTimeLabel() {
        timeLabel.translatesAutoresizingMaskIntoConstraints = false

        timeLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor).isActive = true
        timeLabel.topAnchor.constraint(equalTo: bubbleView.bottomAnchor,
                                       constant: Constants.Margin.topTimeLabel).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                          constant: Constants.Margin.bottomTimeLabel).isActive = true
    }

}

// MARK: - BaseTableViewCell
extension ChatReceivedFileTableViewCell: BaseTableViewCell {

    static func heightFor(width: CGFloat, model: TableViewCellModel?) -> CGFloat {
        guard let model = model as? ChatTableViewCellModel else {
            return 0
        }

        model.height = Constants.Margin.heightContentView
        return model.height
    }

    func update(with model: TableViewCellModel?) {
        guard let model = model as? ChatTableViewCellModel else {
                return
        }

        timeLabel.setStyle(with: model.message.messageTime, style: TextStyle.ReceivedMessageStyle.Label.dateStyle)

        ImageFetcher.fetch(with: model.message.messageFileInfo?.getURL(),
                           to: fileImageView) { [weak self] (image, _) in
                            model.message.messageImage = self?.fileImageView.image
        }
    }

}
