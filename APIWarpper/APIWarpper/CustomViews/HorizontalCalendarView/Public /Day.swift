import Foundation

// MARK: - Day

/// Represents a day (with a corresponding year and month) in a particular calendar. All days are assumed to have been instantiated
/// with the same `Calendar`, which is enforced throughout the implementation.
public struct Day {

  // MARK: Lifecycle

  init(month: Month, day: Int) {
    self.month = month
    self.day = day
  }

  // MARK: Public

  public let month: Month
  public let day: Int

  public var components: DateComponents {
    DateComponents(era: month.era, year: month.year, month: month.month, day: day)
  }

}

// MARK: CustomStringConvertible

extension Day: CustomStringConvertible {

  public var description: String {
    let yearDescription = String(format: "%04d", month.year)
    let monthDescription = String(format: "%02d", month.month)
    let dayDescription = String(format: "%02d", day)
    return "\(yearDescription)-\(monthDescription)-\(dayDescription)"
  }

}

// MARK: Equatable

extension Day: Equatable {

  public static func == (lhs: Day, rhs: Day) -> Bool {
    lhs.month == rhs.month && lhs.day == rhs.day
  }

}

// MARK: Hashable

extension Day: Hashable {

  public func hash(into hasher: inout Hasher) {
    hasher.combine(month)
    hasher.combine(day)
  }

}

// MARK: Comparable

extension Day: Comparable {

  public static func < (lhs: Day, rhs: Day) -> Bool {
    guard lhs.month == rhs.month else { return lhs.month < rhs.month }
    return lhs.day < rhs.day
  }

}
