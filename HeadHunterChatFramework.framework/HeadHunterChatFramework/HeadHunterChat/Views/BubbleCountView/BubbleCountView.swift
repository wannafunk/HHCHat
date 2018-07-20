//
//  BubbleCountView
//  HeadHunterChat
//
//  Created by Harbros 3 on 16.07.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//
import UIKit

class BubbleCountView: UIView {

    // MARK: - Constants
    private enum Constants {
        static let nibName = "BubbleCountView"
    }

    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var countView: UIView!
    @IBOutlet private weak var countLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        countView.layer.cornerRadius = countView.bounds.height / 2
    }

    private func setup() {
        Bundle.main.loadNibNamed(Constants.nibName, owner: self, options: nil)
        addSubview(contentView)

        setupContentView()
        setupCountView()
    }

    private func setupContentView() {
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    private func setupCountView() {
        countView.isHidden = true
        countView.layer.masksToBounds = true
        countView.backgroundColor = AppStyle.Color.mainBlue
    }

    private func setupCountLabel() {
        countLabel.translatesAutoresizingMaskIntoConstraints = false

        countLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        countLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        countLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        countLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    // MARK: - Public
    func set(count: Int) {
        if count == 0 {
            countView?.isHidden = true
        } else {
            countView?.isHidden = false
            countLabel?.setStyle(with: "\(count)", style: TextStyle.ReceivedMessageStyle.Label.textStyle)
        }
    }

}
