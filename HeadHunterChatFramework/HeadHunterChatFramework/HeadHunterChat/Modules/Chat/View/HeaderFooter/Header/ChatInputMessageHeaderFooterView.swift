//
//  ChatInputMessageHeaderFooterView.swift
//  HeadHunterChat
//
//  Created by 12345 on 09.07.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

//
//  ChatInputMessageTableViewCell.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 06.07.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit

final class ChatInputMessageHeaderFooterView: UITableViewHeaderFooterView {

    private enum Constants {
        //AvatarImageView
        static let cornerRadiusAvatarImageView: CGFloat = 15

        //ContentView
        static let heightContentView: CGFloat = 38

        enum Margin {
            //AvatarImageView
            static let leadingAvatarImageView: CGFloat = 16
            static let trailingAvatarImageView: CGFloat = -16
            static let topAvatarImageView: CGFloat =  4
            static let bottomAvatarImageView: CGFloat = -4
            static let heightAvatarImageView: CGFloat = 30
            static let widthAvatarImageView: CGFloat = 30
        }
    }

    private let avatarImageView = UIImageView()
    private let pointsImageView = UIImageView()

    private let images = [#imageLiteral(resourceName: "InputMessageFirstIcon"), #imageLiteral(resourceName: "InputMessageSecondIcon"), #imageLiteral(resourceName: "InputMessageThirdIcon"), #imageLiteral(resourceName: "InputMessageFourthIcon")]

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setup()
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        setup()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        pointsImageView.stopAnimating()
        layer.removeAllAnimations()

        avatarImageView.image = nil
        sd_cancelCurrentImageLoad()
    }

    // MARK: - Utility Methods
    private func setup() {
        contentView.backgroundColor = .white

        contentView.addSubview(avatarImageView)
        contentView.addSubview(pointsImageView)

        setupLoadingImages()
        setupPointsImageView()
    }

    private func setupLoadingImages() {
        avatarImageView.layer.cornerRadius = Constants.cornerRadiusAvatarImageView
        avatarImageView.layer.masksToBounds = true
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        avatarImageView.backgroundColor = AppStyle.Color.mainAquamarine

        avatarImageView.translatesAutoresizingMaskIntoConstraints = false

        avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                 constant: Constants.Margin.leadingAvatarImageView).isActive = true
        avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                             constant: Constants.Margin.topAvatarImageView).isActive = true
        avatarImageView.trailingAnchor.constraint(equalTo: pointsImageView.leadingAnchor,
                                                  constant: Constants.Margin.trailingAvatarImageView).isActive = true
        avatarImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                constant: Constants.Margin.bottomAvatarImageView).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: Constants.Margin.heightAvatarImageView).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: Constants.Margin.widthAvatarImageView).isActive = true
    }

    private func setupPointsImageView() {
        pointsImageView.contentMode = .scaleAspectFit

        pointsImageView.translatesAutoresizingMaskIntoConstraints = false

        pointsImageView.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor).isActive = true

        // Add image animation
        pointsImageView.animationImages = images
        pointsImageView.animationDuration = 1
    }

}

// MARK: - BaseTableViewCell
extension ChatInputMessageHeaderFooterView: BaseTableViewHeaderFooterView {

    static func height(withWidth width: CGFloat, model: TableViewHeaderFooterModel?) -> CGFloat {
        return Constants.heightContentView
    }

    func update(model: TableViewHeaderFooterModel?) {
        pointsImageView.startAnimating()

        guard
            let model = model as? ChatTableViewHeaderFooterViewModel,
            let currentOperator = model.currentOperator
        else {
            return
        }

        ImageFetcher.fetch(with: currentOperator.operatorAvatarURL, to: avatarImageView)
    }

}
