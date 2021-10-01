import Foundation

// MARK: - MonthRange

public typealias MonthRange = ClosedRange<Month>

extension MonthRange {

  // MARK: Lifecycle

  /// Instantiates a `MonthRange` that encapsulates the `dateRange` in the `calendar` as closely as possible. For example,
  /// a date range of [2020-01-19, 2021-02-01] will result in a month range of [2020-01, 2021-02].
  init(containing dateRange: ClosedRange<Date>, in calendar: Calendar) {
    self.init(
      uncheckedBounds: (
        lower: calendar.month(containing: dateRange.lowerBound),
        upper: calendar.month(containing: dateRange.upperBound)))
  }

}
