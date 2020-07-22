//
//  ConversationModels.swift
//  Messenger
//
//  Created by Valeriy Kovalevskiy on 7/22/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

import Foundation


struct Conversation {
    let id: String
    let name: String
    let otherUserEmail: String
    let latestMessage: LatestMessage
}

struct LatestMessage {
    let date: String
    let text: String
    let isRead: Bool
}
