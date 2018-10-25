//
// Wire
// Copyright (C) 2018 Wire Swiss GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//

import Foundation

extension ConversationMessageWindowTableViewAdapter {
    
    @objc func registerTableCellClasses() {
        tableView.register(ImageMessageCell.self, forCellReuseIdentifier: ConversationImageCellId)
        tableView.register(ConversationRenamedCell.self, forCellReuseIdentifier: ConversationNameChangedCellId)
        tableView.register(PingCell.self, forCellReuseIdentifier: ConversationPingCellId)
        tableView.register(PerformedCallCell.self, forCellReuseIdentifier: ConversationPerformedCallCellId)
        tableView.register(MissedCallCell.self, forCellReuseIdentifier: ConversationMissedCallCellId)
        tableView.register(ConnectionRequestCell.self, forCellReuseIdentifier: ConversationConnectionRequestCellId)
        tableView.register(ConversationNewDeviceCell.self, forCellReuseIdentifier: ConversationNewDeviceCellId)
        tableView.register(ConversationVerifiedCell.self, forCellReuseIdentifier: ConversationVerifiedCellId)
        tableView.register(MissingMessagesCell.self, forCellReuseIdentifier: ConversationMissingMessagesCellId)
        tableView.register(ConversationIgnoredDeviceCell.self, forCellReuseIdentifier: ConversationIgnoredDeviceCellId)
        tableView.register(CannotDecryptCell.self, forCellReuseIdentifier: ConversationCannotDecryptCellId)
        tableView.register(FileTransferCell.self, forCellReuseIdentifier: ConversationFileTransferCellId)
        tableView.register(VideoMessageCell.self, forCellReuseIdentifier: ConversationVideoMessageCellId)
        tableView.register(AudioMessageCell.self, forCellReuseIdentifier: ConversationAudioMessageCellId)
        tableView.register(ParticipantsCell.self, forCellReuseIdentifier: ParticipantsCell.zm_reuseIdentifier)
        tableView.register(LocationMessageCell.self, forCellReuseIdentifier: ConversationLocationMessageCellId)
        tableView.register(MessageDeletedCell.self, forCellReuseIdentifier: ConversationMessageDeletedCellId)
        tableView.register(UnknownMessageCell.self, forCellReuseIdentifier: ConversationUnknownMessageCellId)
        tableView.register(MessageTimerUpdateCell.self, forCellReuseIdentifier: ConversationMessageTimerUpdateCellId)
    }
}

extension ConversationMessageWindowTableViewAdapter: UITableViewDataSource {

    @objc(buildSectionControllerForMessage:)
    func buildSectionController(for message: ZMConversationMessage) -> ConversationMessageSectionController {
        return messageWindow.sectionController(for: message, firstUnreadMessage: firstUnreadMessage)
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.messageWindow.messages.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionController = self.sectionController(at: section, in: tableView)!
        return sectionController.numberOfCells
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionController = self.sectionController(at: indexPath.section, in: tableView)!
        return sectionController.makeCell(for: tableView, at: indexPath)

//        let description = messageWindow.description(for: message, firstUnreadMessage: firstUnreadMessage)
//
//        return description.cell(tableView: tableView, at: indexPath)

//        let description = messageWindow.cellDescription(for: message)
//        
//        return description.cell(for: tableview)
//        
//        if message.isImage {
//            description.cell(from: tableView)
//            let cell = tableView.dequeueConfigurableCell(for: message, for: indexPath)
//            cell.configure(with: message)
//        }
//        
//        if message.isImage {
//            let properties = messageWindow.layoutProperties(for: message, firstUnreadMessage: firstUnreadMessage)!
//            let description = MessageCellDescription(layout: properties)
//            let cell = tableView.dequeueReusableCell(withIdentifier: description.reuseIdentifier, for: indexPath) as! TableViewCellDescriptionAdapter<NewImageMessageCell>
//            cell.configure(with: message)
//            return cell
//        }
//        
//        if message.isText {
//            let properties = messageWindow.layoutProperties(for: message, firstUnreadMessage: firstUnreadMessage)!
//            let messageCellDescription = MessageCellDescription(layout: properties)
//            let description = TextCellDescription(messageCellDescription, attachment: message.textMessageData?.linkPreview != nil ? .linkPreview : .none)
//            let cell = tableView.dequeueReusableCell(withIdentifier: description.reuseIdentifier, for: indexPath) as! TableViewCellDescriptionAdapter<NewTextMessageCell>
//            cell.configure(with: message)
//            return cell
//        }

//        let cell = tableView.dequeueReusableCell(withIdentifier: message.cellIdentifier, for: indexPath)
//
//        // Newly created cells will have a size of {320, 44}, which leads to layout problems when they contain `UICollectionViews`.
//        // This is needed as long as `ParticipantsCell` contains a `UICollectionView`.
//        var bounds = cell.bounds
//        bounds.size.width = tableView.bounds.size.width
//        cell.bounds = bounds
//
//        guard let conversationCell = cell as? ConversationCell else { return cell }
//
//        conversationCell.searchQueries = searchQueries
//        conversationCell.delegate = conversationCellDelegate
//        // Configuration of the cell is not possible when `ZMUserSession` is not available.
//        if let _ = ZMUserSession.shared() {
//            configureConversationCell(conversationCell, with: message)
//        }
//        return conversationCell
    }
}

extension ZMConversationMessage {
    var cellIdentifier: String {
        var cellIdentifier = ConversationUnknownMessageCellId

        if isVideo {
            cellIdentifier = ConversationVideoMessageCellId
        } else if isAudio {
            cellIdentifier = ConversationAudioMessageCellId
        } else if isLocation {
            cellIdentifier = ConversationLocationMessageCellId
        } else if isFile {
            cellIdentifier = ConversationFileTransferCellId
        } else if isImage {
            cellIdentifier = ConversationImageCellId
        } else if isSystem, let systemMessageType = systemMessageData?.systemMessageType {
            switch systemMessageType {
            case .connectionRequest:
                cellIdentifier = ConversationConnectionRequestCellId
            case .connectionUpdate:
                break
            case .conversationNameChanged:
                cellIdentifier = ConversationNameChangedCellId
            case .missedCall:
                cellIdentifier = ConversationMissedCallCellId
            case .newClient, .usingNewDevice:
                cellIdentifier = ConversationNewDeviceCellId
            case .ignoredClient:
                cellIdentifier = ConversationIgnoredDeviceCellId
            case .conversationIsSecure:
                cellIdentifier = ConversationVerifiedCellId
            case .potentialGap, .reactivatedDevice:
                cellIdentifier = ConversationMissingMessagesCellId
            case .decryptionFailed, .decryptionFailed_RemoteIdentityChanged:
                cellIdentifier = ConversationCannotDecryptCellId
            case .participantsAdded, .participantsRemoved, .newConversation, .teamMemberLeave:
                cellIdentifier = ParticipantsCell.zm_reuseIdentifier
            case .messageDeletedForEveryone:
                cellIdentifier = ConversationMessageDeletedCellId
            case .performedCall:
                cellIdentifier = ConversationPerformedCallCellId
            case .messageTimerUpdate:
                cellIdentifier = ConversationMessageTimerUpdateCellId
            default:
                break
            }
        } else {
            cellIdentifier = ConversationUnknownMessageCellId
        }
        
        return cellIdentifier
    }
}
