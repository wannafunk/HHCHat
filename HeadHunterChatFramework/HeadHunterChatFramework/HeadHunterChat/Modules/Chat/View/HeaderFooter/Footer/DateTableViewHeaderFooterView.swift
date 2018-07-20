//
//  DateTableViewHeaderFooterView.swift
//  HeadHunterChat
//
//  Created by 12345 on 04.07.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

//
//  DateTableViewCell.swift
//  HeadHunterChat
//
//  Created by 12345 on 04.07.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit

class DateTableViewHeaderFooterView: UITableViewHeaderFooterView {

    private enum Constants {
        enum Margin {
            static let heightTimeLabel: CGFloat = 16
            static let heightContentView: CGFloat = 52

            //LeftRightGradientView
            static let leadingLeftRightGradientView: CGFloat = 23
            static let trailingLeftRightGradientView: CGFloat = -4
            static let heightLeftRightGradientView: CGFloat = 1

            //RightLeftGradientView
            static let leadingRightLeftGradientView: CGFloat = 4
            static let trailingRightLeftGradientView: CGFloat = -23
            static let heightRightLeftGradientView: CGFloat = 1
        }
    }

    private let timeLabel = UILabel()

    private let leftRightGradientView = UIImageView()
    private let rightLeftGradientView = UIImageView()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setup()
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        setup()
    }

    // MARK: - Utility Methods
    private func setup() {
        contentView.addSubview(timeLabel)
        contentView.addSubview(leftRightGradientView)
        contentView.addSubview(rightLeftGradientView)

        setupTimeLabel()
        setupLeftRightGradientView()
        setupRightLeftGradientView()
    }

    private func setupTimeLabel() {
        timeLabel.translatesAutoresizingMaskIntoConstraints = false

        timeLabel.heightAnchor.constraint(equalToConstant: Constants.Margin.heightTimeLabel).isActive = true
        timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 4).isActive = true
    }

    private func setupLeftRightGradientView() {
        leftRightGradientView.image = #imageLiteral(resourceName: "LeftGradientIcon")
        leftRightGradientView.translatesAutoresizingMaskIntoConstraints = false

        leftRightGradientView.trailingAnchor.constraint(
            equalTo: timeLabel.leadingAnchor, constant: Constants.Margin.trailingLeftRightGradientView
        ).isActive = true
        leftRightGradientView.heightAnchor.constraint(
            equalToConstant: Constants.Margin.heightLeftRightGradientView
        ).isActive = true
        leftRightGradientView.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor).isActive = true
    }

    private func setupRightLeftGradientView() {
        rightLeftGradientView.image = #imageLiteral(resourceName: "RightGradientIcon")
        rightLeftGradientView.translatesAutoresizingMaskIntoConstraints = false

        rightLeftGradientView.leadingAnchor.constraint(
            equalTo: timeLabel.trailingAnchor, constant: Constants.Margin.leadingRightLeftGradientView
        ).isActive = true
        rightLeftGradientView.heightAnchor.constraint(
            equalToConstant: Constants.Margin.heightRightLeftGradientView
        ).isActive = true
        rightLeftGradientView.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor).isActive = true
    }

}

// MARK: - BaseTableViewHeaderFooterView
extension DateTableViewHeaderFooterView: BaseTableViewHeaderFooterView {

    static func height(withWidth width: CGFloat, model: TableViewHeaderFooterModel?) -> CGFloat {
        return Constants.Margin.heightContentView
    }

    func update(model: TableViewHeaderFooterModel?) {
        guard let model = model as? ChatTableViewHeaderFooterViewModel else {
            return
        }

        timeLabel.setStyle(with: model.date, style: TextStyle.FooterMessageStyle.Label.textStyle)
    }

}
