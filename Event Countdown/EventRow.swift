import SwiftUI

/// Displays a single event in a horizontal layout with image thumbnail and event details
/// Shows the event's image (or placeholder), title, and relative time using RelativeDateTimeFormatter
struct EventRow: View {
    
    let event: Event
    
    /// Initializes the EventRow with the given event
    init(event: Event) {
        self.event = event /// The event to display in this row
    }
    
    /// Formatter for displaying relative time strings like "in 2 days" or "5 minutes ago"
    private var relativeDateFormatter: RelativeDateTimeFormatter = {
        
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter
        
    }()
    
    var body: some View {
        
        HStack(spacing: 12) {
            
            if let imageData = event.imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(8)
                    .clipped()
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 50, height: 50)
                    .overlay(
                        Image(systemName: "photo")
                            .foregroundColor(.gray)
                    )
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(event.title)
                    .font(.headline)
                    .foregroundColor(event.textColor)
                
                Text(relativeDateFormatter.localizedString(for: event.date, relativeTo: Date()))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        
        .padding(.vertical, 2)
    }
    
}
