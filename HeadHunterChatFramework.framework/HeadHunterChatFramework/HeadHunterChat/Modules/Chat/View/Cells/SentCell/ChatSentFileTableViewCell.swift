//
//  ChatSentFileTableViewCell.swift
//  HeadHunterChat
//
//  Created by 12345 on 27.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit
import SDWebImage

final class ChatSentFileTableViewCell: UITableViewCell {

    private enum Constants {
        static let cornerRadius: CGFloat = 8

        enum Margin {
            //BubbleView
            static let trailingBubbleView: CGFloat = -20
            static let topBubbleView: CGFloat =  5

            //FileImageView
            static let heightFileImageView: CGFloat =  164
            static let widthFileImageView: CGFloat = 164

            //TimeLabel
            static let topTimeLabel: CGFloat =  8
            static let bottomTimeLabel: CGFloat = -5

            //ActivityIndicator
            static let heightActivityIndicator: CGFloat = 10
            static let widthActivityIndicator: CGFloat = 10
            static let scaleFactorActivityIndicator: CGFloat = 0.6

            //ContentView
            static let heightContentView: CGFloat = 197
        }
    }

    private let bubbleView = ChatSentView()
    private let fileImageView = UIImageView()
    private let timeLabel = UILabel()
    private let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    var fileImage: UIImage?

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
        fileImageView.sd_cancelCurrentAnimationImagesLoad()
    }

    // MARK: - Utility Methods
    private func setup() {
        backgroundColor = .clear

        contentView.addSubview(bubbleView)
        contentView.addSubview(fileImageView)
        contentView.addSubview(timeLabel)
        contentView.addSubview(activityIndicator)

        setupFileImageView()
        setupBubleView()
        setupTimeLabel()
        setupActivityIndicator()
    }

    private func setupBubleView() {
        bubbleView.backgroundColor = AppStyle.Color.mainLightGray
        bubbleView.layer.masksToBounds = true
        bubbleView.layer.cornerRadius = Constants.cornerRadius

        bubbleView.translatesAutoresizingMaskIntoConstraints = false

        bubbleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                             constant: Constants.Margin.trailingBubbleView).isActive = true
        bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                        constant: Constants.Margin.topBubbleView).isActive = true
    }

    private func setupFileImageView() {
        fileImageView.layer.masksToBounds = true
        fileImageView.layer.cornerRadius = Constants.cornerRadius
        fileImageView.clipsToBounds = true
        fileImageView.contentMode = .scaleAspectFill

        fileImageView.translatesAutoresizingMaskIntoConstraints = false

        fileImageView.leadingAnchor.constraint(greaterThanOrEqualTo: bubbleView.leadingAnchor).isActive = true
        fileImageView.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor).isActive = true
        fileImageView.topAnchor.constraint(equalTo: bubbleView.topAnchor).isActive = true
        fileImageView.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor).isActive = true
        fileImageView.heightAnchor.constraint(equalToConstant: Constants.Margin.heightFileImageView).isActive = true
        fileImageView.widthAnchor.constraint(equalToConstant: Constants.Margin.widthFileImageView).isActive = true
    }

    private func setupActivityIndicator() {
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.scale(factor: Constants.Margin.scaleFactorActivityIndicator)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor).isActive = true
        activityIndicator.trailingAnchor.constraint(equalTo: timeLabel.trailingAnchor).isActive = true
    }

    private func setupTimeLabel() {
        timeLabel.translatesAutoresizingMaskIntoConstraints = false

        timeLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor).isActive = true
        timeLabel.topAnchor.constraint(equalTo: bubbleView.bottomAnchor,
                                       constant: Constants.Margin.topTimeLabel).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                          constant: Constants.Margin.bottomTimeLabel).isActive = true
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
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }

}

// MARK: - BaseTableViewCell
extension ChatSentFileTableViewCell: BaseTableViewCell {

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

        timeLabel.setStyle(with: model.message.messageTime, style: TextStyle.SentMessageStyle.Label.dateStyle)

        configureFromStatusMessage(by: model.message.sendStatus)

        ImageFetcher.fetch(with: model.message.messageFileInfo?.getURL(),
                           to: fileImageView) { [weak self] (image, _) in
                            model.message.messageImage = self?.fileImageView.image
        }
    }

}
