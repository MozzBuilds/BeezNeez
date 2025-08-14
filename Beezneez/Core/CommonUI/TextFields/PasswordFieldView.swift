import SwiftUI

struct PasswordFieldView: View {
    
    let placeholder: String
    
    @Binding var fieldHasBeenEdited: Bool
    @Binding var text: String
    @Binding var fieldValidState: FieldValidState
    
    @State private var isSecured: Bool = true

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
        
        Section {
            
            HStack {

                Group {
                    
                    Image(systemName: "lock.fill")
                        .foregroundColor(.blue)
                        .padding(.horizontal, -20)
                    
                    if isSecured {
                        SecureField(placeholder, text: $text)
                    } else {
                        TextField(placeholder, text: $text)
                    }
                }
                .placeholder(when: text.isEmpty)
                 {
                     Text("\(placeholder)")
                         .foregroundColor(.blue)
                }
                .foregroundColor(.blue)
                .padding()
                .frame(width: UIScreen.main.bounds.width * 0.8, height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .frame(height: 1)
                        .foregroundColor(.blue)
//                        .offset(y: Constants.Dimensions.buttonWidth * 0.075)
                )
                .autocapitalization(.none)
                .onChange(of: text) { _ in
                    fieldHasBeenEdited = true
                }

                Button(action: {
                    isSecured.toggle()
                }) {
                    Image(systemName: self.isSecured ? "eye.slash" : "eye")
                        .accentColor(.gray)
                        .foregroundColor(.blue)
                }
                .buttonStyle(.plain)
                .padding(.horizontal, -50)
            }
            .frame(width: UIScreen.main.bounds.width * 0.9)
        }
        footer: {
            if fieldValidState == .nonValid {
                FieldValidationErrorView(text: "passwordValidationError".localized)
            } else if fieldValidState == .nonMatch {
                FieldValidationErrorView(text: "passwordMismatch".localized)
            }
        }
    }
}

struct PasswordField_Previews: PreviewProvider {
    static var previews: some View {
        
        VStack {
            PasswordFieldView(placeholder: "Enter it here", fieldHasBeenEdited: .constant(true), text: .constant(""), fieldValidState: .constant(.nonValid))
        }
    }
}
