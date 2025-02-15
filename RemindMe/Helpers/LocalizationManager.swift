import Foundation
import SwiftUI

struct LocalizationManager {
    static func localizedString(_ key: String, languageCode: String) -> String {
        let path = Bundle.main.path(forResource: languageCode, ofType: "lproj")
        let bundle = path != nil ? Bundle(path: path!) : Bundle.main
        return NSLocalizedString(key, bundle: bundle ?? .main, comment: "")
    }
} 