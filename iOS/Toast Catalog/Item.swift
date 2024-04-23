import Foundation

struct Item: Identifiable, Hashable, Codable {
    let id: Int
    let name: String
    let price: String
    let currency: String
    let lastSold: Date

    enum CodingKeys: String, CodingKey {
        case id, name, price, currency
        case lastSold = "last_sold"
    }
}

