//
//  ChatAvatarTableViewCell.swift
//  HeadHunterChat
//
//  Created by 12345 on 04.07.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit

final class ChatAvatarTableViewCell: UITableViewCell {

    private enum Constants {
        static let cornerRadiusAvatarImageView: CGFloat = 15

        enum Margin {
            //AvatarImageView
            static let leadingAvatarImageView: CGFloat = 20
            static let topAvatarImageView: CGFloat =  8
            static let bottomAvatarImageView: CGFloat = -8
            static let heightAvatarImageView: CGFloat = 30
            static let widthAvatarImageView: CGFloat = 30

            //NameLabel
            static let leadingNameLabel: CGFloat =  8

            //ContentView
            static let heightContentView: CGFloat = 46
        }
    }

    private let avatarImageView = UIImageView()
    private let nameLabel = UILabel()

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

        avatarImageView.image = nil
        sd_cancelCurrentImageLoad()
    }

    // MARK: - Utility Methods
    private func setup() {
        backgroundColor = .clear

        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameLabel)

        setupAvatarImageView()
        setupNameLabel()
    }

    private func setupAvatarImageView() {
        avatarImageView.layer.cornerRadius = Constants.cornerRadiusAvatarImageView
        avatarImageView.backgroundColor = AppStyle.Color.mainDarkGray
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.masksToBounds = true

        avatarImageView.translatesAutoresizingMaskIntoConstraints = false

        avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                             constant: Constants.Margin.topAvatarImageView).isActive = true
        avatarImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                constant: Constants.Margin.bottomAvatarImageView).isActive = true
        avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                 constant: Constants.Margin.leadingAvatarImageView).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: Constants.Margin.heightAvatarImageView).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: Constants.Margin.widthAvatarImageView).isActive = true
    }

    private func setupNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,
                                           constant: Constants.Margin.leadingNameLabel).isActive = true
    }

}

// MARK: - BaseTableViewCell
extension ChatAvatarTableViewCell: BaseTableViewCell {

    static func heightFor(width: CGFloat, model: TableViewCellModel?) -> CGFloat {
        guard let model = model as? ChatTableViewCellModel else {
            return 0
        }

        model.height = Constants.Margin.heightContentView

        return Constants.Margin.heightContentView
    }

    func update(with model: TableViewCellModel?) {
        guard let model = model as? ChatTableViewCellModel else {
                return
        }

        nameLabel.setStyle(with: model.message.senderName, style: TextStyle.AvatarMessageStyle.Label.textStyle)

        ImageFetcher.fetch(with: model.message.senderAvatarFullURL, to: avatarImageView)
    }

}
