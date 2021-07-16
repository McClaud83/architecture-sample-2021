import UIKit
import Common

extension UICollectionView {
    /// Регистрирует класс ячейки для использования в `UICollectionView`
    ///
    /// - Parameter cellType: Тип ячейки, которая реализует протокол `Reusable`
    public func registerCellClass<T: UICollectionViewCell>(_ cellType: T.Type) {
        register(cellType, forCellWithReuseIdentifier: cellType.reuseID)
    }

    /// Регистрирует nib файл ячейки для использования в `UICollectionView`
    ///
    /// - Parameter cellType: Тип ячейки, которая реализует протокол `Reusable`
    public  func registerCellNib<T: UICollectionViewCell>(_ cellType: T.Type) {
        let nib = UINib(nibName: cellType.reuseID, bundle: nil)
        register(nib, forCellWithReuseIdentifier: cellType.reuseID)
    }

    /// Возвращает экземпляр переиспользуемой ячейки по ее типу.
    ///
    /// - Parameters:
    ///   - cellType: Тип ячейки (должна реализовывать протокол Reusable).
    ///   - indexPath: Index path.
    /// - Returns: Экземпляр ячейки.
    public  func dequeueReusableCell<T: UICollectionViewCell>(
        ofType cellType: T.Type,
        at indexPath: IndexPath
    ) -> T {
        guard
            let cell = dequeueReusableCell(withReuseIdentifier: cellType.reuseID, for: indexPath) as? T
        else {
            fatalError("❌ Не удалось найти ячейку с идентификатором \(cellType.reuseID)!")
        }
        
        return cell
    }
}
