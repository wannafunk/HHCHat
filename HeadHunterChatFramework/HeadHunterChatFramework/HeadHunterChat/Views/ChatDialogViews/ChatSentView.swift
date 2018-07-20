//
//  ChatSentView.swift
//  HeadHunterChat
//
//  Created by 12345 on 19.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit

final class ChatSentView: UIView {

    private enum Constants {
        static let cornerRadius: CGFloat = 8
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    // MARK: Utility methods
    private func setup() {
        backgroundColor = AppStyle.Color.mainBlue

        layer.masksToBounds = true

        setupCornerRadius()
    }

    private func setupCornerRadius() {
        layer.cornerRadius = Constants.cornerRadius
    }

}
