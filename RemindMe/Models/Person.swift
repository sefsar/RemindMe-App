import Foundation
import UIKit

struct Person: Identifiable, Codable {
    var id = UUID()
    var name: String
    var birthday: Date
    var notes: String
    var imageData: Data?
    
    var image: UIImage? {
        if let data = imageData {
            return UIImage(data: data)
        }
        return nil
    }
    // Add more fields as needed
} 