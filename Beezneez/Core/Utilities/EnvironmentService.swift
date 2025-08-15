import Foundation

struct EnvironmentService {
    
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }
    
    /// P.List Values
    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
            throw Error.missingKey
        }
        
        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
    
    /// Flag for checking if PreviewData should be used
    static let isPreviewMode: Bool = {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }()
    
    /// App build number for version number tagging
    static var appBuildNumber: String = {
        (try? value(for: "CFBundleVersion")) ?? ""
    }()
}
