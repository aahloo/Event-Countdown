import SwiftUI

/// Enum defining whether the EventForm is being used to add a new event or edit an existing one
enum EventFormMode {
    case add
    case edit(Event)
}

/// Form view for adding new events or editing existing events
/// Provides input fields for title, date, color, and image selection with validation
struct EventForm: View {
    
    let mode: EventFormMode
    let onSave: (Event) -> Void
    
    @State private var title: String = ""
    @State private var date: Date = Date()
    @State private var textColor: Color = .primary
    @State private var imageData: Data? = nil
    
    /// Computed property that validates if the title field contains valid text
    private var isValidTitle: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    /// Dynamic navigation title based on mode - "Add Event" or "Edit (event title)"
    private var navigationTitle: String {
        switch mode {
        case .add:
            return "Add Event"
        case .edit(let event):
            return "Edit \(event.title)"
        }
    }
    
    /// Initializes the EventForm with the specified mode and save callback
    init(mode: EventFormMode, onSave: @escaping (Event) -> Void) {
        
        self.mode = mode /// Whether this is for adding (.add) or editing (.edit) an event
        self.onSave = onSave /// Callback closure called when the user saves the event
        
        if case .edit(let event) = mode {
            _title = State(initialValue: event.title)
            _date = State(initialValue: event.date)
            _textColor = State(initialValue: event.textColor)
            _imageData = State(initialValue: event.imageData)
        }
        
    }
    
    var body: some View {
        
        Form {
            Section {
                TextField("Event Title", text: $title)
                
                DatePicker("Date", selection: $date)
                
                ColorPicker("Text Color", selection: $textColor)
                
                ImagePicker(selectedImageData: $imageData)
            }
            
            if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                Section(header: Text("Image Preview")) {
                    HStack {
                        Spacer()
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 200)
                            .cornerRadius(8)
                        Spacer()
                    }
                    
                    Button("Remove Image", role: .destructive) {
                        self.imageData = nil
                    }
                }
            }
        }
        .navigationTitle(navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    saveEvent()
                }
                .disabled(!isValidTitle)
            }
        }
        
    }
    
    /// Handles the save action by creating an Event object and calling the onSave callback
    private func saveEvent() {
        
        let event: Event
        
        switch mode {
        case .add:
            event = Event(title: title, date: date, textColor: textColor, imageData: imageData)
        case .edit(let existingEvent):
            var updatedEvent = existingEvent
            updatedEvent.title = title
            updatedEvent.date = date
            updatedEvent.textColor = textColor
            updatedEvent.imageData = imageData
            event = updatedEvent
        }
        
        onSave(event)
        
    }
    
}

/// Extension to make EventFormMode conform to Equatable protocol
extension EventFormMode: Equatable {
    
    static func == (lhs: EventFormMode, rhs: EventFormMode) -> Bool {
        
        switch (lhs, rhs) {
        case (.add, .add):
            return true
        case (.edit(let event1), .edit(let event2)):
            return event1.id == event2.id
        default:
            return false
        }
        
    }
    
}

/// Extension to make EventFormMode conform to Hashable protocol for use with NavigationLink
extension EventFormMode: Hashable {
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .add:
            hasher.combine("add")
        case .edit(let event):
            hasher.combine("edit")
            hasher.combine(event.id)
        }
    }
    
}
