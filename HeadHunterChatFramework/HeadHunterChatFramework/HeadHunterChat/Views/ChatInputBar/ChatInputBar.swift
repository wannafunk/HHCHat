//
//  ChatInputBar.swift
//  HeadHunterChat
//
//  Created by 12345 on 21.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit

protocol ChatInputBarProtocol: class {

    func sendMessage(with text: String)

    func openSelectPhoto()

    func onTextViewDidChange(with text: String)

}

class ChatInputBar: UIView {

    private enum Constants {
        //ShadowView
        static let cornerRadiusShadowView: CGFloat = 20
        static let borderWidthShadowView: CGFloat = 0.5

        //UIEdgeInsets
        static let topInsetTextView: CGFloat = 10
        static let leftInsetTextView: CGFloat = 13
        static let bottomInsetTextView: CGFloat = 10
        static let rightInsetTextView: CGFloat = 0
    }

    @IBOutlet private weak var textView: PlaceholderTextView!
    @IBOutlet private weak var outputButton: UIButton!
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var shadowView: UIView!

    weak var delegate: ChatInputBarProtocol?

    private var imagePicker: UIImagePickerController = UIImagePickerController()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setup()
    }

    // MARK: - Utility methods
    private func setup() {
        Bundle.main.loadNibNamed("ChatInputBar", owner: self, options: nil)

        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        setupTextView()
        setupShadowView()
    }

    private func setupTextView() {
        textView.placeholder = TextConstants.placeholderInputTextView
        textView.delegate = self
        textView.textContainerInset = UIEdgeInsets(top: Constants.topInsetTextView,
                                                   left: Constants.leftInsetTextView,
                                                   bottom: Constants.bottomInsetTextView,
                                                   right: Constants.rightInsetTextView)
    }

    private func setupShadowView() {
        shadowView.layer.cornerRadius = Constants.cornerRadiusShadowView
        shadowView.layer.masksToBounds = true
        shadowView.layer.borderWidth = Constants.borderWidthShadowView
        shadowView.layer.borderColor = UIColor.lightGray.cgColor
    }

    // MARK: - Utility methods
    private func reset() {
        textView.text = ""
        textView.setContentHeight()

        changeStateOutputButton(isUserInteractionEnabled: false, image: #imageLiteral(resourceName: "SendGrayIcon"))
    }

    private func changeStateOutputButton(isUserInteractionEnabled: Bool,
                                         image: UIImage) {
        outputButton.isUserInteractionEnabled = isUserInteractionEnabled
        outputButton.setImage(image, for: .normal)
    }

    // MARK: - Send message action
    @IBAction private func sendMessageAction(_ sender: Any) {
        guard let text = textView.text else {
            return
        }

        delegate?.sendMessage(with: text)
        reset()
    }

    @IBAction private func addFileAction(_ sender: Any) {
        delegate?.openSelectPhoto()
    }

}

// MARK: - UITextViewDelegate
extension ChatInputBar: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        let textWithoutSpaces = textView.text.trimmingCharacters(in: .whitespaces)
        let textWithoutLineBreak = textWithoutSpaces.replacingOccurrences(
            of: TextConstants.NotLocalized.newLine, with: ""
        ).trimmingCharacters(in: .whitespaces)
        let image = textWithoutLineBreak.count > 0 ? #imageLiteral(resourceName: "SendIcon") : #imageLiteral(resourceName: "SendGrayIcon")

        changeStateOutputButton(isUserInteractionEnabled: textWithoutLineBreak.count > 0,
                                image: image)

        if let textView = textView as? PlaceholderTextView {
            if textView.text.isEmpty {
                textView.placeholder = TextConstants.placeholderInputTextView
            }

            textView.setContentHeight()
        }

        delegate?.onTextViewDidChange(with: textView.text)
    }

}
