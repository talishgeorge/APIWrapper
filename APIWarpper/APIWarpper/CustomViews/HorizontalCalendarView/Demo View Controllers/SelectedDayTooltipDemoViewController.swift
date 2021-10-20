
import UIKit

final class SelectedDayTooltipDemoViewController: DemoViewController {

  // MARK: Internal

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Selected Day Tooltip"

    calendarView.daySelectionHandler = { [weak self] day in
      guard let self = self else { return }

      self.selectedDate = self.calendar.date(from: day.components)
      self.calendarView.setContent(self.makeContent())

      if UIAccessibility.isVoiceOverRunning, let selectedDate = self.selectedDate {
        self.calendarView.layoutIfNeeded()
        let accessibilityElementToFocus = self.calendarView.accessibilityElementForVisibleDate(
          selectedDate)
        UIAccessibility.post(notification: .screenChanged, argument: accessibilityElementToFocus)
      }
    }
  }

  override func makeContent() -> CalendarViewContent {
    let startDate = calendar.date(from: DateComponents(year: 2020, month: 01, day: 01))!
    let endDate = calendar.date(from: DateComponents(year: 2021, month: 12, day: 31))!

    let selectedDate = self.selectedDate

    let overlaidItemLocations: Set<CalendarViewContent.OverlaidItemLocation>
    if let selectedDate = selectedDate {
      overlaidItemLocations = [.day(containingDate: selectedDate)]
    } else {
      overlaidItemLocations = []
    }

    return CalendarViewContent(
      calendar: calendar,
      visibleDateRange: startDate...endDate,
      monthsLayout: monthsLayout)

      .withInterMonthSpacing(24)

      .withDayItemModelProvider { [calendar, dayDateFormatter] day in
        var invariantViewProperties = CalendarDayView.InvariantViewProperties.baseInteractive

        let date = calendar.date(from: day.components)
        if date == selectedDate {
          invariantViewProperties.backgroundShapeDrawingConfig.borderColor = .blue
            
//          invariantViewProperties.backgroundShapeDrawingConfig.fillColor = .blue.withAlphaComponent(0.15)
        }

        return CalendarItemModel<CalendarDayView>(
          invariantViewProperties: invariantViewProperties,
          viewModel: .init(
            dayText: "\(day.day)",
            accessibilityLabel: date.map { dayDateFormatter.string(from: $0) },
            accessibilityHint: nil))
      }

      .withOverlayItemModelProvider(for: overlaidItemLocations) { overlayLayoutContext in
        CalendarItemModel<TooltipView>(
          invariantViewProperties: .init(),
          viewModel: .init(
            frameOfTooltippedItem: overlayLayoutContext.overlaidItemFrame,
            text: "Selected Day"))
      }
  }

  // MARK: Private

  private var selectedDate: Date?

}
