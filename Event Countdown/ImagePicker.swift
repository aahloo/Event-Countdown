import SwiftUI
import PhotosUI


struct ImagePicker: View {
    
    @Binding var selectedImageData: Data?
    @State private var selectedItem: PhotosPickerItem?
    
    var body: some View {
        
        /// PhotosPicker for selecting images from the photo library; displays a selectable row with visual feedback when an image is chosen
        PhotosPicker(
            selection: $selectedItem,
            matching: .images,
            photoLibrary: .shared()
        ) {
            HStack {
                Image(systemName: "photo")
                    .foregroundColor(.blue)
                Text("Select Image")
                Spacer()
                if selectedImageData != nil {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                }
            }
        }
        .onChange(of: selectedItem) { _, newValue in
            Task {
                if let newValue = newValue {
                    if let data = try? await newValue.loadTransferable(type: Data.self) {
                        await MainActor.run {
                            selectedImageData = data
                        }
                    }
                }
            }
        }
        
    }
    
}
