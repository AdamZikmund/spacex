import Foundation

extension InputStream {
    var utf8String: String? {
        let length = 1024
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: length)
        var data = Data()
        open()
        while hasBytesAvailable {
            let count = read(buffer, maxLength: length)
            data.append(buffer, count: count)
        }
        buffer.deallocate()
        return String(data: data, encoding: .utf8)
    }
}
