import Foundation

extension Bundle {
    public static func smth(for name: String) -> Any? {
        let bundle = Bundle(for: self.classForCoder())
        return bundle.loadNibNamed(name, owner: nil, options: nil)?.first
    }
}
