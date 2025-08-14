import SwiftUI

/// Valid state enum used by all validators
enum FieldValidState {
    case untouched
    case valid
    case nonValid
    case nonMatch
}

struct FieldValidationErrorView: View {
    
    /// Displays a very simple text error, likely used in the footer of a field
    let text: String

    var body: some View {
        Text(text)
            .padding()
            .foregroundColor(.red)
    }
}

struct FieldValidationErrorView_Previews: PreviewProvider {
    static var previews: some View {
        FieldValidationErrorView(text: "This be an error")
    }
}
