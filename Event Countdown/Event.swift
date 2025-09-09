import Foundation
import SwiftUI

struct Event: Identifiable, Codable {
    
    let id: UUID
    var title: String
    var date: Date
    var textColor: Color
    var imageData: Data?
    
    /// Initializes a new Event with default values for optional parameters
    init(title: String = "", date: Date = Date(), textColor: Color = .primary, imageData: Data? = nil) {
        
        self.id = UUID()
        self.title = title /// The event's display name
        self.date = date /// When the event occurs
        self.textColor = textColor /// Color for displaying the event title
        self.imageData = imageData /// Optional image data associated with the event
        
    }
    
    /// Keys used for encoding/decoding Event properties to/from JSON
    enum CodingKeys: String, CodingKey {
        case id, title, date, textColor, imageData
    }
    
    /// Custom decoder initializer to handle Color decoding from archived UIColor data
    init(from decoder: Decoder) throws { /// The decoder containing the Event data
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        date = try container.decode(Date.self, forKey: .date)
        
        if let colorData = try? container.decode(Data.self, forKey: .textColor) {
            textColor = Color(try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData) ?? UIColor.label)
        } else {
            textColor = .primary
        }
        
        imageData = try container.decodeIfPresent(Data.self, forKey: .imageData)
        
    }
    
    /// Custom encoder function to handle Color encoding to archived UIColor data    
    func encode(to encoder: Encoder) throws { /// The encoder to write the Event data to
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(date, forKey: .date)
        
        let uiColor = UIColor(textColor)
        let colorData = try NSKeyedArchiver.archivedData(withRootObject: uiColor, requiringSecureCoding: false)
        
        try container.encode(colorData, forKey: .textColor)
        try container.encodeIfPresent(imageData, forKey: .imageData)
        
    }
    
}
