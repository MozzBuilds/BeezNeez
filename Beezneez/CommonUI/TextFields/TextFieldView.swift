import SwiftUI

struct TextFieldView: View {
    
    let placeholder: String
    
    @Binding var fieldHasBeenEdited: Bool
    @Binding var text: String
    @Binding var fieldValidState: FieldValidState
    
    private var backgroundColor: Color {
        switch fieldValidState {
        case .untouched:
            return Colors.white
        case .valid:
            return Colors.white
        case .nonValid, .nonMatch:
            return Colors.white
        }
    }

    var body: some View {
        
        TextField("", text:$text)
            .placeholder(when: text.isEmpty)
             {
                 Text("\(placeholder)").foregroundColor(.blue)
            }
             .foregroundColor(.blue)
            .padding()
            .frame(width: UIScreen.main.bounds.width * 0.8, height: 40)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .frame(height: 1)
                    .foregroundColor(.blue)
//                    .offset(y: Constants.Dimensions.buttonWidth * 0.075)
            )
            .onChange(of: text) { _ in
                fieldHasBeenEdited = true
            }
            .autocorrectionDisabled(true)
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(placeholder: "Enter it here", fieldHasBeenEdited: .constant(true), text: .constant(""), fieldValidState: .constant(.valid))

    }
}
