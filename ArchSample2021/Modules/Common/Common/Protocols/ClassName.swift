import Foundation

public protocol ClassName {
    static var className: String { get }
}

extension ClassName {
    public static var className: String {
        return String(describing: self)
    }
}
