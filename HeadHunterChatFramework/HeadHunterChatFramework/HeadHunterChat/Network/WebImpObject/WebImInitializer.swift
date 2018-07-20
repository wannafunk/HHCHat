//
//  WebImInitializer.swift
//  HeadHunterChat
//
//  Created by Harbros 3 on 17.07.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit
import WebimClientLibrary

final class WebImInitializerImpl: WebImInitializer {

    static let delayForReconnection = 5.0

    var webimSession: WebimSession?
    var messageStream: MessageStream?
    var messageTracker: MessageTracker?
    weak var messageListener: MessageListener?
    weak var errorHandler: FatalErrorHandler?
    weak var webImLoger: WebimLogger?

    init(errorHandler: FatalErrorHandler, webImLoger: WebimLogger, messageListener: MessageListener) {
        self.errorHandler = errorHandler
        self.messageListener = messageListener
        self.webImLoger = webImLoger

        self.createSession(errorHandler: errorHandler, webImLoger: webImLoger)
        self.setMessageStream()
        self.setMessageTracker(withMessageListener: messageListener)
    }

    func setOperatorTypingListener(operatorListener: OperatorTypingListener) {
        self.messageStream?.set(operatorTypingListener: operatorListener)
    }

    private func createSession(errorHandler: FatalErrorHandler, webImLoger: WebimLogger) {
        let deviceToken: String? = UserDefaults.standard.object(forKey: "") as? String

        let sessionBuilder = Webim.newSessionBuilder()
            .set(accountName: Settings.shared.accountName)
            .set(location: Settings.shared.location)
            .set(pageTitle: Settings.shared.pageTitle)
            .set(fatalErrorHandler: errorHandler)
            .set(remoteNotificationSystem: ((deviceToken != nil) ? .APNS : .NONE))
            .set(deviceToken: deviceToken)
            .set(isVisitorDataClearingEnabled: false)
            .set(webimLogger: webImLoger,
                 verbosityLevel: .VERBOSE)

        //        if Settings.shared.accountName == Settings.DefaultSettings.accountName.rawValue {
        //            sessionBuilder = sessionBuilder.set(visitorFieldsJSONString:
        //                """
        //                {\"\(VisitorFields.id.rawValue)\"
        //                :\"\(VisitorFieldsValue.id.rawValue)\",\"\(VisitorFields.name.rawValue)\"
        //                :\"\(VisitorFieldsValue.name.rawValue)\",\"\(VisitorFields.crc.rawValue)\"
        //                :\"\(VisitorFieldsValue.crc.rawValue)\"}
        //                """)
        //            // Hardcoded values that work with "demo" account only!
        //        }

        do {
            webimSession = try sessionBuilder.build()
        } catch let error as SessionBuilder.SessionBuilderError {
            // Assuming to check parameters values in Webim session builder methods.
            switch error {
            case .NIL_ACCOUNT_NAME:
                print("Webim session object creating failed because of passing nil account name.")
            case .NIL_LOCATION:
                print("Webim session object creating failed because of passing nil location name.")
            case .INVALID_REMOTE_NOTIFICATION_CONFIGURATION:
                print("Webim session object creating failed because of invalid remote notifications configuration.")
            case .INVALID_AUTHENTICATION_PARAMETERS:
                print("""
            Webim session object creating failed because of invalid visitor authentication system
                    configuration.
""")
            }
        } catch {
            print("Webim session object creating failed with unknown error: \(error.localizedDescription)")
        }
    }

    private func setMessageStream() {
        messageStream = webimSession?.getStream()
    }

    private func setMessageTracker(withMessageListener messageListener: MessageListener) {
        do {
            if messageStream == nil {
                setMessageStream()
            }
            try messageTracker = messageStream?.newMessageTracker(messageListener: messageListener)
        } catch let error as AccessError {
            switch error {
            case .INVALID_SESSION:
                DispatchQueue.main.asyncAfter(deadline: .now() + WebImInitializerImpl.delayForReconnection, execute: {
                    self.recreateWebImSession()
                })
            case .INVALID_THREAD:
                DispatchQueue.main.async {
                    self.recreateWebImSession()
                }
            }
        } catch {
            print("Webim session starting/resuming failed with unknown error: \(error.localizedDescription)")
        }
    }

}

extension WebImInitializerImpl {

    func recreateWebImSession() {
        guard
            let errorHandler = self.errorHandler,
            let webImLoger = self.webImLoger
        else {
            return
        }

        createSession(errorHandler: errorHandler, webImLoger: webImLoger)
        recreateMessageStream()
        recreateMessageTracker()
    }

    func recreateMessageStream() {
        self.setMessageStream()
    }

    func recreateMessageTracker() {
        guard let messageListener = self.messageListener else {
            return
        }

    self.setMessageTracker(withMessageListener: messageListener)
    }

}

protocol WebImInitializer {

    var webimSession: WebimSession? { get set }
    var messageStream: MessageStream? { get set }
    var messageTracker: MessageTracker? { get set }

    func recreateWebImSession()
    func recreateMessageStream()
    func recreateMessageTracker()

}
