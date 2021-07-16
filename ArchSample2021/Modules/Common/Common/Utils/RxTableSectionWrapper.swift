import UIKit
import RxSwift
import RxCocoa
import RxDataSources

public final class RxTableSectionWrapper<T>:
    RxTableViewSectionedReloadDataSource<T>,
    UITableViewDelegate
    where T: SectionModelType {
}
