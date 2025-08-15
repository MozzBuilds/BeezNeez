import SwiftUI

struct Separator: View {
    /// Creates a line break, for separating items in a scrollview with a custom look
    let color: Color = .gray
    let thickness: CGFloat = 3
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: thickness)
            .edgesIgnoringSafeArea(.horizontal)
    }
}

struct RoundedCorner: Shape {
    ///Round the corner of a shape
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct UnderlinedTextModifier: ViewModifier {
    /// For underlining text. Does the same as .underline, but  .underline is not available till iOS16
    func body(content: Content) -> some View {
        content
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .padding(.bottom, 1)
                    .foregroundColor(.blue),
                alignment: .bottom
            )
    }
}

struct RadioToggle: ToggleStyle {
    /// Radio style toggle button
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "largecircle.fill.circle" : "circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(configuration.isOn ? .blue : .gray)
        }
        .onTapGesture {
            configuration.isOn.toggle()
        }
    }
}

struct CheckBox: ToggleStyle {
    /// Check Box toggle button
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(configuration.isOn ? .blue : .gray)
        }
        .onTapGesture {
            configuration.isOn.toggle()
        }
    }
}


struct CircularScaleView: View {
    /// Circular shaped path, can be used to indicate completeness of something
    /// Angle is based upon the current value, and maximum
    /// Also displays the current value in the centre, and has space for an image below
    
    let value: Int
    let warnValue: Int
    let maxValue: Double = 50
    
    let radius = 25.0
    let startAngle: Angle = .degrees(135)
    let endAngle: Angle = .degrees(45)
    let circleWidth = 3.0
    
    var body: some View {
        
        ZStack {

            Text("\(value)")
                .foregroundColor(.blue.opacity(0.8))
                .zIndex(2)
            
            Path { path in
                            
                path.addArc(
                    center: CGPoint(x: 25, y: 25),
                    radius: radius,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: false
                )
            }
            .stroke(.gray.opacity(0.8), lineWidth: circleWidth)
            .zIndex(1)
            
            Path { path in
                                
                path.addArc(
                    center: CGPoint(x: 25, y: 25),
                    radius: radius,
                    startAngle: startAngle,
                    endAngle: actualEndAngle,
                    clockwise: false
                )
            }
            .stroke(value <= warnValue ? .red : .blue,
                    lineWidth: circleWidth)
            .zIndex(3)
            
            Image("SomeImage") // REPLACE THIS WITH THE IMAGE USED
                .resizable()
                .frame(width: 30, height: 23)
                .position(CGPoint(x: 23, y: 50))

        }
        .frame(width: 50, height: 50)

    }
    
    private var actualEndAngle: Angle {
        /// Used for the complex logic in the above scale to workaround swift's way of angle handling
        let angleDifference: Angle = .degrees(360 - startAngle.degrees + endAngle.degrees)
        let maxAngle: Angle = .degrees(angleDifference.degrees + startAngle.degrees)
        let newEndAngle: Angle = .degrees(startAngle.degrees + angleDifference.degrees * (Double(value) / maxValue))
        return .degrees(min(newEndAngle.degrees, maxAngle.degrees))
    }
}
