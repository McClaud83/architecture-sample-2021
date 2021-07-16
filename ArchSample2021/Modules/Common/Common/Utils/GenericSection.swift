import Foundation
import RxDataSources

public struct GenericSection<T>: SectionModelType, Equatable where T: Equatable {
    public let title: String?
    public var items: [T]

    public init(title: String?, items: [T]) {
        self.title = title
        self.items = items
    }

    public init(original: GenericSection, items: [T]) {
        self = original
        self.items = items
    }
}
