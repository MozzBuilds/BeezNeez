import SwiftUI

struct NameFieldView: View {
    
    let placeholder: String
    
    @Binding var fieldHasBeenEdited: Bool
    @Binding var text: String
    @Binding var fieldValidState: FieldValidState
    
    var body: some View {
        
        Section {
            TextFieldView(placeholder: placeholder, fieldHasBeenEdited: $fieldHasBeenEdited, text: $text, fieldValidState: $fieldValidState)
                .textContentType(.username)
                .keyboardType(.asciiCapable) // don't allow emojis to be displayed in keyboard
            
        } footer: {
            if fieldValidState == .nonValid {
                FieldValidationErrorView(text: "nameValidationError".localized)
//                    .frame(width: Constants.Dimensions.buttonWidth)
            }
        }
    }
}

struct NameFieldView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NameFieldView(placeholder: "Enter it here", fieldHasBeenEdited: .constant(true), text: .constant(""), fieldValidState: .constant(.nonValid))
        }
    }
}
