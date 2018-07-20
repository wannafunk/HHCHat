import Foundation
import WebimClientLibrary

protocol WebSocketApiServiceDelegate: class {

//    func webSocketApiServiceDidConnect  (_ service: WebSocketApiService)
//    func webSocketApiServiceDidDisonnect(_ service: WebSocketApiService)
    func webSocketApiService(_ service: WebSocketApiService,
                             didRecieveMessage message: DTOMessage,
                             fromEvent: ChatEvent)
    func webSocketApiService(_ service: WebSocketApiService,
                             didChangeMessage oldMessage: DTOMessage,
                             to newMessage: DTOMessage)

}

protocol WebSocketApiService {

    var delegates: MulticastDelegate<WebSocketApiServiceDelegate> { get }

}

protocol WebSocketApiRequester {

    func sendMessage(text: String, completion: @escaping (Result<SentMessage>) -> Void)
    func sendFile(with fileData: Data,
                  fileName: String,
                  mimeType: String,
                  completion: @escaping (Result<SentMessage>) -> Void)
    func setVisitorTyping(with text: String, completion: @escaping (Result<SentMessage>) -> Void)
}

class WebSocketApiServiceImpl: WebSocketApiService {

    private struct Constants {
        static let type = "type"
        static let reconnectTimeInterval = 3
    }

    private var reconnectTimer: DispatchSourceTimer?

   // private let webSocketTaskManager: WebSocketTaskManager
    private let webSocketClient: WebSocketClient
   // private let messageWrapper: MessageWrapper

    // MARK: - Lifecycle

    init(webSocketClient: WebSocketClient) {
       // self.webSocketTaskManager = webSocketTaskManager
        self.webSocketClient      = webSocketClient
        //self.messageWrapper       = messageWrapper

        webSocketClient.delegates.addDelegate(self)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationBecomeActive),
                                               name: NSNotification.Name.UIApplicationDidBecomeActive,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationWillResignActive),
                                               name: NSNotification.Name.UIApplicationWillResignActive,
                                               object: nil)

        connect()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    var delegates = MulticastDelegate<WebSocketApiServiceDelegate>()

    // MARK: - Connection managing
    private func connect() {
        if !webSocketClient.isConnected {
            webSocketClient.connect()
        }
    }

    private func disconnect() {
        webSocketClient.disconnect()
    }

    private func reconnect() {
        startTimer()
    }

    private func startTimer() {
        guard reconnectTimer == nil else {
            return
        }

        print ("[WebSocketApiServiceImpl] start reconect timer")

        reconnectTimer   = DispatchSource.makeTimerSource(flags: .strict, queue: DispatchQueue.main)
        let timeInterval = DispatchTimeInterval.seconds(Constants.reconnectTimeInterval)
        reconnectTimer?.schedule(deadline: .now() + timeInterval, repeating: timeInterval, leeway: .milliseconds(300))
        reconnectTimer?.setEventHandler { [weak self] in
            guard let `self` = self else {
                return
            }
            if !self.webSocketClient.isConnected {
                print ("[WebSocketApiServiceImpl] try reconnecting...")
                self.connect()
            }
        }
        reconnectTimer?.resume()
    }

    // MARK: - Private methods

    @objc func applicationBecomeActive() {
        connect()
    }

    @objc func applicationWillResignActive() {
        disconnect()
    }

}

// MARK: - WebSocketApiRequester
extension WebSocketApiServiceImpl: WebSocketApiRequester {

    func sendMessage(text: String, completion: @escaping (Result<SentMessage>) -> Void) {
        webSocketClient.send(message: text, completion: completion)
    }

    func sendFile(with fileData: Data,
                  fileName: String,
                  mimeType: String,
                  completion: @escaping (Result<SentMessage>) -> Void) {
        webSocketClient.send(fileData: fileData,
                             fileName: fileName,
                             mimeType: mimeType,
                             completion: completion)
    }

    func setVisitorTyping(with text: String, completion: @escaping (Result<SentMessage>) -> Void) {
        webSocketClient.setVisitorTyping(with: text, completion: completion)
    }

}

extension Data {

    func convertToDic() -> [String: Any]? {
        if let dict = try? JSONSerialization.jsonObject(with: self) as? [String: Any] {
            return dict
        } else {
            return nil
        }
    }

}

// MARK: - WebSocketClientDelegate
extension WebSocketApiServiceImpl: WebSocketClientDelegate {

    func webSocketClient(_ client: WebSocketClient, didRecieveMessage message: DTOMessage) {
        print(message)
        delegates.invokeDelegates { $0.webSocketApiService(self,
                                                           didRecieveMessage: message,
                                                           fromEvent: ChatEvent.chatMessage)
        }
    }

    func webSocketClient(_ client: WebSocketClient,
                         didChangeMessage oldMessage: DTOMessage,
                         to newMessage: DTOMessage) {
        delegates.invokeDelegates { $0.webSocketApiService(self,
                                                           didChangeMessage: oldMessage,
                                                           to: newMessage)
        }
    }

    func webSocketClientDidConnect(_ client: WebSocketClient) {
        delegates.invokeDelegates { _ in
            // delegate.webSocketApiServiceDidConnect(self) // MARK: - Maybe temp comment
        }

        reconnectTimer?.cancel()
        reconnectTimer = nil
    }

    func webSocketClientDidDisconnect(_ client: WebSocketClient) {
        delegates.invokeDelegates { _ in
            //  delegate.webSocketApiServiceDidDisonnect(self) // MARK: - Maybe temp comment
        }

        reconnect()
    }

}
