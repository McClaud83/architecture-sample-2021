import UIKit

extension UITableView {
    /// Регистрирует класс ячейки для использования в `UITableView`
    ///
    /// - Parameter cellType: Тип ячейки, которая реализует протокол `Reusable`
    public func registerCellClass<T: UITableViewCell>(_ cellType: T.Type) {
        register(cellType, forCellReuseIdentifier: cellType.reuseID)
    }

    /// Регистрирует класс ячейки для использования в `UITableView`
    ///
    /// - Parameter cellType: Тип ячейки, которая реализует протокол `Reusable`
    public func registerHeaderFooterClass<T: UITableViewHeaderFooterView>(_ viewType: T.Type) {
        register(viewType, forHeaderFooterViewReuseIdentifier: viewType.reuseID)
    }

    /// Регистрирует nib файл ячейки для использования в `UITableView`
    ///
    /// - Parameter cellType: Тип ячейки, которая реализует протокол `Reusable`
    public func registerCellNib<T: UITableViewCell>(_ cellType: T.Type) {
        let bundle = Bundle(for: T.self)
        //        super.init(nibName: String(describing: Self.self), bundle: bundle)

        let nib = UINib(nibName: cellType.reuseID, bundle: bundle)
        register(nib, forCellReuseIdentifier: cellType.reuseID)
    }

    /// Возвращает экземпляр переиспользуемой ячейки по ее типу.
    ///
    /// - Parameters:
    ///   - cellType: Тип ячейки (должна реализовывать протокол Reusable).
    ///   - indexPath: Index path.
    /// - Returns: Экземпляр ячейки.
    public func dequeueReusableCell<T: UITableViewCell>(
        ofType cellType: T.Type,
        at indexPath: IndexPath
    ) -> T {
        guard
            let cell = dequeueReusableCell(withIdentifier: cellType.reuseID, for: indexPath) as? T
        else {
            fatalError("❌ Не удалось найти ячейку с идентификатором \(cellType.reuseID)")
        }
        return cell
    }

    /// Возвращает экземпляр переиспользуемой view по ее типу.
    ///
    /// - Parameters:
    ///   - viewType: Тип view (должна реализовывать протокол Reusable).
    /// - Returns: Экземпляр view.
    public func dequeueReusableHeaderFooter<T: UITableViewHeaderFooterView>(ofType viewType: T.Type) -> T {
        guard
            let view = dequeueReusableHeaderFooterView(withIdentifier: viewType.reuseID) as? T
        else {
          fatalError("❌ Не удалось найти view с идентификатором \(viewType.reuseID)")
        }
        return view
    }
}
