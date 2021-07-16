import Foundation
import RxSwift
import RxCocoa

extension PrimitiveSequence {
    public func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { error in
            return Driver.empty()
        }
    }
}
