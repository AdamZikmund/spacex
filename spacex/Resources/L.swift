struct L {
	private init() {}
	struct SortView {
		private init() {}
		static func key(_ language: Language) -> String {
			switch language {
			case .en:
				return String(format: "Key")
			case .cs:
				return String(format: "Klic")
			}
		}
		static func direction(_ language: Language) -> String {
			switch language {
			case .en:
				return String(format: "Direction")
			case .cs:
				return String(format: "Smer")
			}
		}
		static func apply(_ language: Language) -> String {
			switch language {
			case .en:
				return String(format: "Apply")
			case .cs:
				return String(format: "Potvrdit")
			}
		}
	}
	struct LaunchesViewController {
		private init() {}
		static func title(_ language: Language) -> String {
			switch language {
			case .en:
				return String(format: "Launches")
			case .cs:
				return String(format: "Starty")
			}
		}
		struct Sort {
			private init() {}
			static func title(_ language: Language) -> String {
				switch language {
				case .en:
					return String(format: "Sort")
				case .cs:
					return String(format: "Tridit")
				}
			}
			static func message(_ language: Language) -> String {
				switch language {
				case .en:
					return String(format: "Sort launches by date")
				case .cs:
					return String(format: "Trizeni startu podle data")
				}
			}
		}
	}
	struct Common {
		private init() {}
		static func tryAgain(_ language: Language) -> String {
			switch language {
			case .en:
				return String(format: "Try again")
			case .cs:
				return String(format: "Zkusit znovu")
			}
		}
		static func somethingWentWrong(_ language: Language) -> String {
			switch language {
			case .en:
				return String(format: "Something went wrong!")
			case .cs:
				return String(format: "Neco se pokazilo!")
			}
		}
		static func search(_ language: Language) -> String {
			switch language {
			case .en:
				return String(format: "Search")
			case .cs:
				return String(format: "Vyhledavejte")
			}
		}
		static func loadMore(_ language: Language) -> String {
			switch language {
			case .en:
				return String(format: "Load more")
			case .cs:
				return String(format: "Nacist dalsi")
			}
		}
		static func dESC(_ language: Language) -> String {
			switch language {
			case .en:
				return String(format: "Descending")
			case .cs:
				return String(format: "Sestupne")
			}
		}
		static func aSC(_ language: Language) -> String {
			switch language {
			case .en:
				return String(format: "Ascending")
			case .cs:
				return String(format: "Vzestupne")
			}
		}
	}
}