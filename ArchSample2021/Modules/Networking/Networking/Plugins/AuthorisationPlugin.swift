import Foundation
import Moya
import Constants

struct AuthrisationTokePlugin: PluginType {
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        let key = Constants.UserDefaultsKeys.authToken.rawValue
        guard let token = UserDefaults.standard.string(forKey: key) else { return request }
        print(#fileID, #function, "\nauthToken:", token)
        var request = request
        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        return request
    }
}
