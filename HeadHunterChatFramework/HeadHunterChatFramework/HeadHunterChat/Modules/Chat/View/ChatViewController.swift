//
//  ChatViewController.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 14.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit
import Typist
import NYTPhotoViewer

final class ChatViewController: TableViewController {

    private enum Constants {
        enum Margin {
            //TableView
            static let bottomTableView: CGFloat = -10

            //ChatInputBar
            static let leadingChatInputBar: CGFloat = 18
            static let trailingChatInputBar: CGFloat =  -16
            static let bottomChatInputBar: CGFloat =  -10
            static let heightChatInputBar: CGFloat = 40

            //ActivityIndicator
            static let heightActivityIndicator = 40
            static let widthActivityIndicator = 40

            //ViewForLoader
            static let topViewForLoader: CGFloat = 20

            //ArrowToBottomView
            static let trailingArrowToBottomView: CGFloat = -19
            static let bottomArrowToBottomView: CGFloat = -19
            static let heightArrowToBottomView: CGFloat = 38
            static let widthArrowToBottomView: CGFloat = 38
        }
    }

    private let output: ChatViewOutput

    private let chatInputBar = ChatInputBar()
    private let keyboard = Typist()
    private var imagePicker: UIImagePickerController?
    private let viewForLoader = UIView()
    private let arrowToBottomView = ArrowToBottomView()

    private let photoServices = PhotosServices()

    private var activityIndicator: UIActivityIndicatorView?

    private var bottomConstraint: NSLayoutConstraint?

    init(output: ChatViewOutput, tableViewDataManager: TableViewDataManager) {
        self.output = output
        super.init(tableViewDataManager: tableViewDataManager)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()

        output.viewDidLoad()
    }

    // MARK: Utility methods
    private func setup() {
        view.backgroundColor = AppStyle.Color.white
        view.addSubview(tableView)
        view.addSubview(chatInputBar)
        view.addSubview(viewForLoader)
        view.addSubview(arrowToBottomView)

        setupTableView()
        setupChatInputBar()
        setupNavigationBar()
        setupImagePicker()
        setupKeyboard()
        setupActivityIndicator()
        setupArrowToBottomView()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ChatViewController.hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tapGesture)
    }

    private func setupTableView() {
        tableView.transform = CGAffineTransform(scaleX: 1, y: -1)
        tableView.backgroundColor = UIColor.white

        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        if #available(iOS 11.0, *) {
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        }
        tableView.bottomAnchor.constraint(greaterThanOrEqualTo: chatInputBar.topAnchor,
                                          constant: Constants.Margin.bottomTableView).isActive = true
    }

    private func setupChatInputBar() {
        chatInputBar.delegate = self
        chatInputBar.backgroundColor = .clear

        chatInputBar.translatesAutoresizingMaskIntoConstraints = false

        chatInputBar.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                              constant: Constants.Margin.leadingChatInputBar).isActive = true
        chatInputBar.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                               constant: Constants.Margin.trailingChatInputBar).isActive = true
        bottomConstraint = NSLayoutConstraint(item: chatInputBar,
                                              attribute: .bottom,
                                              relatedBy: .equal,
                                              toItem: view,
                                              attribute: .bottom,
                                              multiplier: 1,
                                              constant: Constants.Margin.bottomChatInputBar)
        if let bottomConstraint = bottomConstraint {
            view.addConstraint(bottomConstraint)
        }
    }

    private func setupNavigationBar() {
        setNavigationTitle(by: TextConstants.chatNavigationTitle)
        setRightButtonItemWithImage(by: #imageLiteral(resourceName: "SmileIcon"))
    }

    private func setupImagePicker() {
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        imagePicker?.allowsEditing = true
        imagePicker?.sourceType = .photoLibrary
        if let mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary) {
            imagePicker?.mediaTypes = mediaTypes
        }
    }

    private func setupActivityIndicator() {
        //Add view for loader
        viewForLoader.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            viewForLoader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                               constant: Constants.Margin.topViewForLoader).isActive = true
        } else {
            // Fallback on earlier versions
        }
        viewForLoader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)

        guard let activityIndicator = activityIndicator else {
            return
        }

        activityIndicator.frame = CGRect(x: 0,
                                         y: 0,
                                         width: Constants.Margin.widthActivityIndicator,
                                         height: Constants.Margin.heightActivityIndicator)
        activityIndicator.hidesWhenStopped = true
        viewForLoader.addSubview(activityIndicator)
        activityIndicator.center = viewForLoader.center
        activityIndicator.startAnimating()
    }

    private func setupArrowToBottomView() {
        arrowToBottomView.isHidden = true
        arrowToBottomView.delegate = self

        arrowToBottomView.translatesAutoresizingMaskIntoConstraints = false

        arrowToBottomView.trailingAnchor.constraint(
            equalTo: tableView.trailingAnchor, constant: Constants.Margin.trailingArrowToBottomView
        ).isActive = true
        arrowToBottomView.bottomAnchor.constraint(
            equalTo: tableView.bottomAnchor, constant: Constants.Margin.bottomArrowToBottomView
            ).isActive = true
        arrowToBottomView.heightAnchor.constraint(
            equalToConstant: Constants.Margin.heightArrowToBottomView
        ).isActive = true
        arrowToBottomView.widthAnchor.constraint(
            equalToConstant: Constants.Margin.widthArrowToBottomView
        ).isActive = true
    }

    // MARK: Setup keyboard
    private func setupKeyboard() {
        keyboard.on(event: .willShow) { [weak self] (options) in
            UIView.animate(withDuration: NumericConstants.animationDurationForKeyboard) {
                self?.bottomConstraint?.constant = -options.endFrame.height + Constants.Margin.bottomChatInputBar

                self?.view.layoutIfNeeded()
            }
        }.on(event: .willHide) { [weak self] (_) in
            UIView.animate(withDuration: NumericConstants.animationDurationForKeyboard) {
                self?.bottomConstraint?.constant =  Constants.Margin.bottomChatInputBar

                self?.view.layoutIfNeeded()
            }
        }.start()
    }

    @objc private func hideKeyboard() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
        }
    }
}

// MARK: VacancyViewInput
extension ChatViewController: ChatViewInput {

    func showLoader() {
        DispatchQueue.main.async {
            self.activityIndicator?.startAnimating()
        }
    }

    func hideLoader() {
        DispatchQueue.main.async {
            self.activityIndicator?.stopAnimating()
        }
    }

    func removeSpinnerForTableView() {
        tableView.tableFooterView = nil
    }

    func showAlert(title: String, message: String, buttonTitle: String, onDismiss: ((UIAlertAction) -> Void)?) {
        view.endEditing(true)

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .cancel, handler: onDismiss))
        present(alert, animated: false, completion: nil)
    }

    func showOpenPhoto(for fileImage: UIImage) {
        let photo = Photo()
        photo.image = fileImage
        let dataSource = NYTPhotoViewerArrayDataSource(photos: [photo])
        let photosViewController = NYTPhotosViewController(dataSource: dataSource, initialPhotoIndex: 0, delegate: nil)
        present(photosViewController, animated: false, completion: nil)
    }

    func updateBubbleCountView(for count: Int) {
        arrowToBottomView.setCountMessage(count: count)
    }

    func setScrollViewDelegate() {
        tableViewDataManager.scrollViewDelegate = self
    }

}

// MARK: ChatInputBarProtocol
extension ChatViewController: ChatInputBarProtocol {

    func openSelectPhoto() {
        photoServices.requestAccess { [weak self] (status) in
            if status == .authorized {
                guard let imagePicker = self?.imagePicker else {
                    return
                }

                DispatchQueue.main.async {
                    self?.present(imagePicker, animated: true, completion: nil)
                }
            } else if status == .denied {
                DispatchQueue.main.async {
                    self?.showAlert(title: TextConstants.errorAlert,
                                    message: TextConstants.cameraAccessAlertText,
                                    buttonTitle: TextConstants.okAlert,
                                    onDismiss: nil)
                }
            }
        }
    }

    func sendMessage(with text: String) {
        let formatText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        output.onMessageSendButtonTap(with: formatText)
        output.onTextViewDidChange(with: "")
    }

    func onTextViewDidChange(with text: String) {
        output.onTextViewDidChange(with: text)
    }

}

// MARK: - UIImagePickerControllerDelegate
extension ChatViewController: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String: Any]) {
        var imageData: Data? = nil

        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            if let data = UIImageJPEGRepresentation(image, 1) {
                imageData = data
            }
        }

        dismiss(animated: true) { [weak self] in
            if let imageData = imageData {
                self?.output.onFileSendButtonTap(with: imageData)
            }
        }
    }

}

// MARK: - UINavigationControllerDelegate
extension ChatViewController: UINavigationControllerDelegate { }

// MARK: UIScrollViewDelegate
extension ChatViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.shouldLoadData(loadDistance: NumericConstants.loadDistance) {
            output.downloadNextMessages()
        }

        if let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows {
            output.indexPathsVisibleRows(indexPathsForVisibleRows)
        }

        arrowToBottomView.isHidden = !scrollView.shouldShowArrowToBottom()
    }

}

// MARK: - ArrowToBottomViewDelegate
extension ChatViewController: ArrowToBottomViewDelegate {

    func onScrollToBottomButtonTap() {
        output.onScrollToBottomButtonTap()
    }

}
