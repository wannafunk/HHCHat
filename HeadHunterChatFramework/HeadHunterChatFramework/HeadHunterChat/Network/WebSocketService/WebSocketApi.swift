import Foundation

 enum VisitorFields: String {
    case id = "id"
    case name = "display_name"
    case crc = "crc"
}

 enum VisitorFieldsValue: String {
    // Hardcoded. See more at https://webim.ru/help/identification/
    case id = "1234567890987654321"
    case name = "Никита"
    case crc = "ffadeb6aa3c788200824e311b9aa44cb"
}

enum ChatEvent: String {
    case startDialog
    case getRoom
    case getRooms
    case getHistoryMessages
    case chatMessage
    case setRead
}
