//
//  ChatTableViewModel.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 14.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import Foundation
import WebimClientLibrary

final class ChatTableViewModel {

    private let sectionModel: CommonSectionViewModel<ChatTableViewCellModel> = CommonSectionViewModel(cells: [])
    private var daysForSections: [Date] = []

    func setMessages(_ messages: [DTOMessage]) {
        let changedMessages = getMessagesWithAvatarForOperator(for: messages)

        let dates = getDateForMessages(changedMessages)

        changedMessages.forEach {
            sectionModel.cells.append(ChatTableViewCellModel(message: $0))
        }

        addDaysForSectionsAndSort(for: dates)
    }

    func addMessage(_ message: DTOMessage) {
        let date = removeTimeStamp(fromDate: message.messageTime)

        if !daysForSections.contains(date) {
            daysForSections.insert(date, at: 0)
        }

        if let cell = sectionModel.cells.first {
            if !cell.message.isOperatorType, message.isOperatorType {
                sectionModel.cells.insert(
                    getAvatarMessageCell(for: message.webImMessage), at: 0
                )
            }
        }

        sectionModel.cells.insert(ChatTableViewCellModel(message: message), at: 0)
    }

    func getIndexPathUpdateMessage(by newMessage: DTOMessage) -> IndexPath? {
        var changeCell: ChatTableViewCellModel? = nil

        for cell in sectionModel.cells where cell.message.messageId == newMessage.messageId {
            cell.message = newMessage

            changeCell = cell
        }

        if let cell = changeCell,
            let indexPath = indexPath(for: cell) {
            return indexPath
        } else {
            return nil
        }
    }

    func addTypingOperator(_ currentOperator: DTOOperator) {
        sectionModel.header = ChatTableViewHeaderFooterViewModel(date: Date(),
                                                                 type: .header,
                                                                 currentOperator: currentOperator)
    }

    func deleteTypingOperator() {
        sectionModel.header = nil
    }

    // MARK: Utility methods
    private func getMessagesCells(_ cells: [ChatTableViewCellModel], date: Date) -> [ChatTableViewCellModel] {
        return cells.filter({
            self.removeTimeStamp(fromDate: $0.message.messageTime) == date
        })
    }

    private func removeTimeStamp(fromDate: Date) -> Date {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day],
                                                                                     from: fromDate)) else {
            return Date()
        }

        return date
    }

    private func getDateForMessages(_ messages: [DTOMessage]) -> [Date] {
        let dates = Array(Set(messages.compactMap({
            self.removeTimeStamp(fromDate: ($0.messageTime))
        })))

        return dates
    }

    private func getMessagesWithAvatarForOperator(for messages: [DTOMessage]) -> [DTOMessage] {
        var newMessageCount = 0
        var mutableMessages = messages

        for (index, message) in mutableMessages.enumerated() where message.isOperatorType &&
            index + newMessageCount + 1 < mutableMessages.count &&
            !mutableMessages[index + newMessageCount + 1].isOperatorType {
                mutableMessages.insert(getAvatarMessage(for: message.webImMessage), at: index + newMessageCount + 1)
                newMessageCount += 1
        }

        return mutableMessages
    }

    private func getAvatarMessageCell(for message: Message) -> ChatTableViewCellModel {
        let cell = ChatTableViewCellModel(message: DTOMessage(fromWebImMessage: message))
        cell.cellClass = ChatAvatarTableViewCell.self
        cell.message.messageType = .avatarOperator

        return cell
    }

    private func getAvatarMessage(for message: Message) -> DTOMessage {
        let message = DTOMessage(fromWebImMessage: message)
        message.messageType = .avatarOperator

        return message
    }

    private func addDaysForSectionsAndSort(for dates: [Date]) {
        dates.forEach { (date) in
            if !daysForSections.contains(date) {
                daysForSections.append(date)
            }
        }

        daysForSections.sort()
        daysForSections.reverse()
    }

}

// MARK: - TableViewModel
extension ChatTableViewModel: TableViewModel {

    func numberOfSections() -> Int {
        return daysForSections.count
    }

    func numberOfRows(inSection section: Int) -> Int {
        if daysForSections.count > 0 {
            return getMessagesCells(sectionModel.cells, date: daysForSections[section]).count
        } else {
            return 0
        }
    }

    func modelForCell(at indexPath: IndexPath) -> TableViewCellModel? {
        if daysForSections.count > 0 {
            return getMessagesCells(sectionModel.cells, date: daysForSections[indexPath.section])[indexPath.row]
        } else {
            return nil
        }
    }

    func modelForFooter(inSection section: Int) -> TableViewHeaderFooterModel? {
        if daysForSections.count > 0 {
            return ChatTableViewHeaderFooterViewModel(date: daysForSections[section], type: .footer)
        } else {
            return nil
        }
    }

    func modelForHeader(inSection section: Int) -> TableViewHeaderFooterModel? {
        if section == 0 {
            return sectionModel.header
        } else {
            return nil
        }
    }

    func indexPath(for cellModel: TableViewCellModel) -> IndexPath? {
        guard let model = cellModel as? ChatTableViewCellModel else {
            return nil
        }

        for (section, date) in daysForSections.enumerated() {
            for (row, cell) in getMessagesCells(sectionModel.cells, date: date).enumerated()
                where cell.message.messageId == model.message.messageId {
                return IndexPath(item: row, section: section)
            }
        }

        return nil
    }

}
