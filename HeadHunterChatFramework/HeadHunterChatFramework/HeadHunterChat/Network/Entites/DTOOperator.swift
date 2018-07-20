//
//  DTOOperator.swift
//  HeadHunterChat
//
//  Created by 12345 on 09.07.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit
import WebimClientLibrary

class DTOOperator {

    var operatorId: String
    var operatorName: String?
    var operatorAvatarURL: URL?

    init?(fromWebImOperator: Operator) {
        operatorId = fromWebImOperator.getID()
        operatorName = fromWebImOperator.getName()
        operatorAvatarURL = fromWebImOperator.getAvatarURL()
    }

}
