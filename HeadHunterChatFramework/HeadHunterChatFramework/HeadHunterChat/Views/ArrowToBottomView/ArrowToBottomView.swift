//
//  ArrowToBottomView.swift
//  HeadHunterChat
//
//  Created by Harbros 3 on 16.07.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit

protocol ArrowToBottomViewDelegate: class {
    func onScrollToBottomButtonTap()
}

class ArrowToBottomView: UIView {

    private enum Constants {
        //ArrowButton
        static let cornerRadiusArrowButton: CGFloat = 19

        enum ImageEdgeInsets {
            //ArrowButton
            static let topArrowButton: CGFloat = 15
            static let bottomArrowButton: CGFloat = 15
            static let leftArrowButton: CGFloat = 12
            static let rightArrowButton: CGFloat = 12
        }

        enum Margin {
            //BubbleCountView
            static let trailingBubbleCountView: CGFloat = 8
            static let topBubbleCountView: CGFloat = -8
        }
    }

    weak var delegate: ArrowToBottomViewDelegate?

    private let arrowButton = UIButton()
    let bubbleCountView = BubbleCountView()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    func setCountMessage(count: Int) {
        bubbleCountView.set(count: count)
    }

    // MARK: Utility methods
    private func setup() {
        addSubview(arrowButton)
        addSubview(bubbleCountView)

        setupImageView()
        setupBubbleCountView()
    }

    private func setupImageView() {
        arrowButton.layer.cornerRadius = Constants.cornerRadiusArrowButton
        arrowButton.layer.masksToBounds = true
        arrowButton.setImage(#imageLiteral(resourceName: "BottomArrowIcon"), for: .normal)
        arrowButton.backgroundColor = AppStyle.Color.mainTransparentGray
        arrowButton.imageEdgeInsets = UIEdgeInsets(top: Constants.ImageEdgeInsets.topArrowButton,
                                                   left: Constants.ImageEdgeInsets.leftArrowButton,
                                                   bottom: Constants.ImageEdgeInsets.bottomArrowButton,
                                                   right: Constants.ImageEdgeInsets.rightArrowButton)
        arrowButton.addTarget(self, action: #selector(ArrowToBottomView.scrollToBottom), for: .touchUpInside)

        arrowButton.contentMode = .scaleAspectFit

        arrowButton.translatesAutoresizingMaskIntoConstraints = false

        arrowButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        arrowButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        arrowButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        arrowButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    private func setupBubbleCountView() {
        bubbleCountView.translatesAutoresizingMaskIntoConstraints = false

        bubbleCountView.trailingAnchor.constraint(equalTo: arrowButton.trailingAnchor,
                                                  constant: Constants.Margin.trailingBubbleCountView).isActive = true
        bubbleCountView.topAnchor.constraint(equalTo: arrowButton.topAnchor,
                                             constant: Constants.Margin.topBubbleCountView).isActive = true
    }

    // MARK: Actions
    @objc func scrollToBottom() {
        delegate?.onScrollToBottomButtonTap()
    }
}
