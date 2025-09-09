import SwiftUI

/// Main view displaying a list of events with navigation and management capabilities;
/// Handles adding, editing, deleting, and persisting events using UserDefaults
struct EventsView: View {
    @State private var events: [Event] = []
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        
        NavigationStack(path: $navigationPath) {
            List {
                ForEach(events) { event in
                    NavigationLink(value: EventFormMode.edit(event)) {
                        EventRow(event: event)
                    }
                    .swipeActions {
                        Button("Delete", role: .destructive) {
                            deleteEvent(event)
                        }
                    }
                }
                .onDelete(perform: deleteEvents)
            }
            .navigationTitle("Events")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(value: EventFormMode.add) {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationDestination(for: EventFormMode.self) { mode in
                EventForm(mode: mode) { event in
                    handleEventSave(event, mode: mode)
                    navigationPath.removeLast()
                }
            }
            .onAppear {
                loadEvents()
            }
        }
    }
    
    /// Handles saving events from the EventForm, routing to add or edit based on mode
    private func handleEventSave(_ event: Event, mode: EventFormMode) { /// The event to save
        
        switch mode { /// Whether this is a new event (.add) or editing existing (.edit)
        case .add:
            addEvent(event)
        case .edit(let originalEvent):
            updateEvent(originalEvent, with: event)
        }
        
    }
    
    /// Adds a new event to the events array, sorts by date, and saves to persistence
    
    private func addEvent(_ event: Event) { /// The event to add
        ///
        events.append(event)
        events.sort { $0.date < $1.date }
        saveEvents()
        
    }
    
    /// Updates an existing event in the events array, sorts by date, and saves to persistence
    private func updateEvent(_ originalEvent: Event, with updatedEvent: Event) {
        
        /// originalEvent: The event to be updated (used to find the correct event by ID)
        if let index = events.firstIndex(where: { $0.id == originalEvent.id }) {
            events[index] = updatedEvent /// updatedEvent: The new event data to replace the original
            events.sort { $0.date < $1.date }
            saveEvents()
        }
        
    }
    
    /// Deletes a specific event from the events array and saves to persistence
    private func deleteEvent(_ event: Event) {
        events.removeAll { $0.id == event.id } /// The event to delete
        saveEvents()
    }
    
    /// Deletes events at specified index positions and saves to persistence
    private func deleteEvents(at offsets: IndexSet) {
        events.remove(atOffsets: offsets) /// The index positions of events to delete
        saveEvents()
    }
    
    // Additional Feature: Data Persistence (UserDefaults approach)
    /// Encodes the current events array and saves it to UserDefaults for persistence
    private func saveEvents() {
        if let data = try? JSONEncoder().encode(events) {
            UserDefaults.standard.set(data, forKey: "SavedEvents")
        }
    }
    
    /// Loads previously saved events from UserDefaults and decodes them into the events array
    private func loadEvents() {
        
        if let data = UserDefaults.standard.data(forKey: "SavedEvents"),
           let savedEvents = try? JSONDecoder().decode([Event].self, from: data) {
            events = savedEvents
        }
        
    }
    
}
