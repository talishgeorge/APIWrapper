
import UIKit

final class DayRangeSelectionDemoViewController: DemoViewController {

  // MARK: Internal

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Day Range Selection"

    calendarView.daySelectionHandler = { [weak self] day in
      guard let self = self else { return }

      switch self.calendarSelection {
      case .singleDay(let selectedDay):
        if day > selectedDay {
          self.calendarSelection = .dayRange(selectedDay...day)
        } else {
          self.calendarSelection = .singleDay(day)
        }
      case .none, .dayRange:
        self.calendarSelection = .singleDay(day)
      }

      self.calendarView.setContent(self.makeContent())

      if
        UIAccessibility.isVoiceOverRunning,
        let selectedDate = self.calendar.date(from: day.components)
      {
        self.calendarView.layoutIfNeeded()
        let accessibilityElementToFocus = self.calendarView.accessibilityElementForVisibleDate(
          selectedDate)
        UIAccessibility.post(notification: .screenChanged, argument: accessibilityElementToFocus)
      }
    }
  }

  override func makeContent() -> CalendarViewContent {
    let startDate = calendar.date(from: DateComponents(year: 2021, month: 09, day: 01))!
    let endDate = calendar.date(from: DateComponents(year: 2021, month: 11, day: 31))!

    let calendarSelection = self.calendarSelection
    var dateRanges: Set<ClosedRange<Date>>
    if
      case .dayRange(let dayRange) = calendarSelection,
      let lowerBound = calendar.date(from: dayRange.lowerBound.components),
      let upperBound = calendar.date(from: dayRange.upperBound.components)
    {
      dateRanges = [lowerBound...upperBound]
    } else {
      dateRanges = []
    }

    let lowerDate = calendar.date(from: DateComponents(year: 2021, month: 10, day: 03))!
    let upperDate = calendar.date(from: DateComponents(year: 2021, month: 10, day: 07))!
    let dateRangeToHighlight = lowerDate...upperDate
    
    dateRanges.insert(dateRangeToHighlight)
    return CalendarViewContent(
      calendar: calendar,
      visibleDateRange: startDate...endDate,
      monthsLayout: monthsLayout)

      .withInterMonthSpacing(24)
      .withVerticalDayMargin(8)
      .withHorizontalDayMargin(8)

      .withDayItemModelProvider { [calendar, dayDateFormatter] day in
        var invariantViewProperties = CalendarDayView.InvariantViewProperties.baseInteractive
        
        let isSelectedStyle: Bool
        switch calendarSelection {
        case .singleDay(let selectedDay):
          isSelectedStyle = day == selectedDay
        case .dayRange(let selectedDayRange):
          isSelectedStyle = day == selectedDayRange.lowerBound || day == selectedDayRange.upperBound
        case .none:
          isSelectedStyle = false
        }

        if isSelectedStyle {
          invariantViewProperties.backgroundShapeDrawingConfig.borderColor = .blue
            invariantViewProperties.textColor = .white
            invariantViewProperties.backgroundShapeDrawingConfig.fillColor = .black
        }

        let date = calendar.date(from: day.components)

        return CalendarItemModel<CalendarDayView>(
          invariantViewProperties: invariantViewProperties,
          viewModel: .init(
            dayText: "\(day.day)",
            accessibilityLabel: date.map { dayDateFormatter.string(from: $0) },
            accessibilityHint: nil))
      }
        
        .withDayRangeItemModelProvider(for: dateRanges) { dayRangeLayoutContext in
            CalendarItemModel<DayRangeIndicatorView>(
                invariantViewProperties: .init(indicatorColor: UIColor.red),
                viewModel: .init(
                    framesOfDaysToHighlight: dayRangeLayoutContext.daysAndFrames.map { $0.frame }))
        }
  }

  // MARK: Private

  private enum CalendarSelection {
    case singleDay(Day)
    case dayRange(DayRange)
  }
  private var calendarSelection: CalendarSelection?

}
