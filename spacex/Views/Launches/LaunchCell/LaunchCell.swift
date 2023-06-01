import Foundation
import UIKit
import Model

class LaunchCell: UITableViewCell {
    static let reuseIdentifier = "LaunchCell"

    // MARK: - Properties
    private var launch: Launch?

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Internal
    func update(launch: Launch) {
        self.launch = launch
        self.setup()
    }

    // MARK: - Private
    private func setup() {
        textLabel?.text = launch?.name
        detailTextLabel?.text = ISO8601DateFormatter().string(from: launch?.date ?? .now)
        accessoryType = .disclosureIndicator
    }
}
