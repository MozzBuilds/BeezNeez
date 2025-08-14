import SwiftUI

struct EmailFieldView: View {
    
    let placeholder: String
    
    @Binding var fieldHasBeenEdited: Bool
    @Binding var text: String
    @Binding var fieldValidState: FieldValidState

    var body: some View {
        
        Section {
            TextFieldView(placeholder: placeholder, fieldHasBeenEdited: $fieldHasBeenEdited, text: $text, fieldValidState: $fieldValidState)
                .autocapitalization(.none)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
            
        } footer: {
            if fieldValidState == .nonValid {
                FieldValidationErrorView(text: "emailValidationError".localized)
            } else if fieldValidState == .nonMatch {
                FieldValidationErrorView(text: "emailMismatch".localized)
            }
            
        }
    }
}

struct EmailFieldView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            EmailFieldView(placeholder: "Enter it here", fieldHasBeenEdited: .constant(true), text: .constant(""), fieldValidState: .constant(.nonValid))
        }
    }
}
