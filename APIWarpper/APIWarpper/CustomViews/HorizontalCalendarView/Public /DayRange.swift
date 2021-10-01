import Foundation

// MARK: - DayRange

public typealias DayRange = ClosedRange<Day>

extension DayRange {

  // MARK: Lifecycle

  /// Instantiates a `DayRange` that encapsulates the `dateRange` in the `calendar` as closely as possible. For example,
  /// a date range of [2020-05-20T23:59:59, 2021-01-01T00:00:00] will result in a day range of [2020-05-20, 2021-01-01].
  init(containing dateRange: ClosedRange<Date>, in calendar: Calendar) {
    self.init(
      uncheckedBounds: (
        lower: calendar.day(containing: dateRange.lowerBound),
        upper: calendar.day(containing: dateRange.upperBound)))
  }

}
