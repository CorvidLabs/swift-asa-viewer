import AppState
import Foundation
import SwiftUI

extension Application {
    var images: State<[URL: UIImage]> {
        state(initial: [:])
    }
}
