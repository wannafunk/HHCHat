import Foundation
import WebimClientLibrary

protocol WebSocketClient {

    var delegates: MulticastDelegate<WebSocketClientDelegate> { get }

    var isConnected: Bool { get }

    func send(message: String, completion: @escaping (Result<SentMessage>) -> Void)
    func send(fileData: Data,
              fileName: String,
              mimeType: String,
              completion: @escaping (Result<SentMessage>) -> Void)
    func setVisitorTyping(with text: String, completion: @escaping (Result<SentMessage>) -> Void)
    func connect()
    func disconnect()

}

protocol WebSocketClientDelegate: class {

    func webSocketClient(_ client: WebSocketClient, didRecieveMessage message: DTOMessage)
    func webSocketClient(_ client: WebSocketClient, didChangeMessage oldMessage: DTOMessage, to newMessage: DTOMessage)
    func webSocketClientDidConnect(_ client: WebSocketClient)
    func webSocketClientDidDisconnect(_ client: WebSocketClient)

}

typealias WebSocketCompletion = (Data) -> Void

class DefaultWebSocketClient: WebSocketClient {

    private var webImIntiliazer: WebImInitializer?
    private let errorMapper: WebImErrorMapping

    init(errorMapper: WebImErrorMapping) {
        self.errorMapper = errorMapper
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationActiveAgain),
                                               name: NSNotification.Name.UIApplicationDidBecomeActive,
                                               object: nil)
    } //DispatchQueue(label: "kz.btsd.websocket.messenger"))

    func setWebImIntiliazer(webImIntiliazer: WebImInitializer) {
        self.webImIntiliazer = webImIntiliazer
    }

    // MARK: - WebSocketClient
    var delegates = MulticastDelegate<WebSocketClientDelegate>()

    var isConnected: Bool {
       return false
    }

    func connect() {
        self.startSession()
    }

    func disconnect() {
        self.stopSession()
    }

}

extension DefaultWebSocketClient {

    func startSession() {
        do {
            try webImIntiliazer?.webimSession?.resume()
        } catch let error as AccessError {
            switch error {
            case .INVALID_SESSION:
                DispatchQueue.main.asyncAfter(deadline: .now() + WebImInitializerImpl.delayForReconnection, execute: {
                   self.webImIntiliazer?.recreateWebImSession()
                })
            case .INVALID_THREAD:
                DispatchQueue.main.async {
                    self.webImIntiliazer?.recreateWebImSession()
                }
            }
        } catch {
            print("Webim session starting/resuming failed with unknown error: \(error.localizedDescription)")
        }

     //   startChat()
    }

    func stopSession() {
        do {
            try webImIntiliazer?.messageTracker?.destroy()
            try webImIntiliazer?.webimSession?.destroy()
        } catch let error as AccessError {
            switch error {
            case .INVALID_SESSION:
                // Ignored because if session is already destroyed,
                //we don't care (it's the same thing that we try to achieve).

                break
            case .INVALID_THREAD:
                // Assuming to check concurrent calls of WebimClientLibrary methods.
                print("Webim session or message tracker destroing failed because it was called from a wrong thread.")
            }
        } catch {
            print("Webim session or message tracker destroing failed with unknown error: \(error.localizedDescription)")
        }
    }

    func getNextMessages(completion: @escaping (_ result: [Message]) -> Void) {
        do {
            try webImIntiliazer?.messageTracker?.getNextMessages(byLimit: 10,
                                                                 completion: completion)
        } catch let error as AccessError {
            switch error {
            case .INVALID_SESSION:
                DispatchQueue.main.asyncAfter(deadline: .now() + WebImInitializerImpl.delayForReconnection, execute: {
                    self.webImIntiliazer?.recreateWebImSession()
                })
            case .INVALID_THREAD:
                DispatchQueue.main.async {
                    self.webImIntiliazer?.recreateWebImSession()
                }
            }
        } catch {
            print("Webim session starting/resuming failed with unknown error: \(error.localizedDescription)")
        }
    }

    @objc func applicationActiveAgain() {
            stopSession()
            webImIntiliazer?.recreateWebImSession()
            startSession()
    }

}

extension DefaultWebSocketClient {

    // MARK: - WebSocketDelegate

    func websocketDidConnect() {
//        print("[DefaultWebSocketClient] websocketDidConnect")
//        /// тут проходим авторизацию
//      socket.emit("authenticate", ["EntityId": userID])
        delegates.invokeDelegates { delegate in
            delegate.webSocketClientDidConnect(self)
        }
    }

    func websocketDidDisconnect(error: Error?) {
//        print("[DefaultWebSocketClient] websocketDidDisconnect \((error as NSError?)?.description ?? "no error")")

        delegates.invokeDelegates { delegate in
            delegate.webSocketClientDidDisconnect(self)
        }
    }

    func websocketDidReceiveMessage(message: DTOMessage) {
     //   print("[DefaultWebSocketClient] websocketDidReceiveMessage \(text)")

        delegates.invokeDelegates { delegate in
            delegate.webSocketClient(self, didRecieveMessage: message)
        }
    }

    func webSocketDidChangeMessage(oldMessage: DTOMessage, newMessage: DTOMessage) {
        delegates.invokeDelegates { delegate in
            if oldMessage.messageId == newMessage.messageId {
                delegate.webSocketClient(self, didChangeMessage: oldMessage, to: newMessage)
            }
        }
    }

   func websocketDidReceiveData(event: ChatEvent, dict: [String: Any]) {
//        print("[DefaultWebSocketClient] websocketDidReceiveData \(data.count)")

        delegates.invokeDelegates { delegate in
            print(delegate)
        }
    }
}

extension DefaultWebSocketClient: MessageListener {

    func removed(message: Message) {
        print(message)
    }

    func removedAllMessages() {

    }

    func changed(message oldVersion: Message, to newVersion: Message) {
        let oldMessage = DTOMessage(fromWebImMessage: oldVersion)
        let newMessage = DTOMessage(fromWebImMessage: newVersion)

        webSocketDidChangeMessage(oldMessage: oldMessage, newMessage: newMessage)
    }

    func added(message newMessage: Message,
               after previousMessage: Message?) {
        let message = DTOMessage(fromWebImMessage: newMessage)

        websocketDidReceiveMessage(message: message)
    }

}

extension DefaultWebSocketClient: FatalErrorHandler {

    func on(error: WebimError) {
            print(error)
    }

}

extension DefaultWebSocketClient: WebimLogger {

    func log(entry: String) {
        print(entry)
    }

}

extension DefaultWebSocketClient {

    func send(message: String, completion: @escaping (Result<SentMessage>) -> Void) {
        do {
            if webImIntiliazer?.messageStream == nil {
                webImIntiliazer?.recreateMessageStream()
            }
            let messageId = try webImIntiliazer?.messageStream?.send(message: message)

            if let messageId = messageId {
                completion(.success(SentMessage(messageId: messageId)))
            }
        } catch let error as AccessError {
            let commonError = errorMapper.convertFromAccessError(error: error)
            completion(.failure(commonError))
        } catch {
            let commonError = CommonError.couldntSendMessage(error.localizedDescription)
            completion(.failure(commonError))
        }
    }

    func send(fileData: Data,
              fileName: String,
              mimeType: String,
              completion: @escaping (Result<SentMessage>) -> Void) {
        do {
            if webImIntiliazer?.messageStream == nil {
                webImIntiliazer?.recreateMessageStream()
            }
            let messageId = try webImIntiliazer?.messageStream?.send(file: fileData,
                                                                     filename: fileName,
                                                                     mimeType: mimeType,
                                                                     completionHandler: nil)
            if let messageId = messageId {
                completion(.success(SentMessage(messageId: messageId)))
            }
        } catch let error as AccessError {
            switch error {
            case .INVALID_SESSION:
                let commonError = errorMapper.convertFromAccessError(error: error)
                completion(.failure(commonError))
            case .INVALID_THREAD:
                let commonError = CommonError.couldntSendMessage(error.localizedDescription)
                completion(.failure(commonError))
            }
        } catch {
            let commonError = CommonError.couldntSendMessage(error.localizedDescription)
            completion(.failure(commonError))
        }
    }

    func setVisitorTyping(with text: String, completion: @escaping (Result<SentMessage>) -> Void) {
        do {
            if webImIntiliazer?.messageStream == nil {
                webImIntiliazer?.recreateMessageStream()
            }

            try webImIntiliazer?.messageStream?.setVisitorTyping(draftMessage: text)
        } catch let error as AccessError {
            switch error {
            case .INVALID_SESSION:
                let commonError = errorMapper.convertFromAccessError(error: error)
                completion(.failure(commonError))
            case .INVALID_THREAD:
                let commonError = CommonError.couldntSendMessage(error.localizedDescription)
                completion(.failure(commonError))
            }
        } catch {
            let commonError = CommonError.couldntSendMessage(error.localizedDescription)
            completion(.failure(commonError))
        }
    }
}
