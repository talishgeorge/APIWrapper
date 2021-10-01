import Foundation

// MARK: - DayOfWeekPosition

/// Represents a day of the week. In the Gregorian calendar, the first position is Sunday and the last position is Saturday. All calendars
/// in `Foundation.Calendar` have 7 day of the week positions.
public enum DayOfWeekPosition: Int, CaseIterable, Equatable {

  // MARK: Public

  case first = 1
  case second
  case third
  case fourth
  case fifth
  case sixth
  case last

  // MARK: Internal

  static let numberOfPositions = 7

}

// MARK: Comparable

extension DayOfWeekPosition: Comparable {

  public static func < (lhs: DayOfWeekPosition, rhs: DayOfWeekPosition) -> Bool {
    lhs.rawValue < rhs.rawValue
  }

}
