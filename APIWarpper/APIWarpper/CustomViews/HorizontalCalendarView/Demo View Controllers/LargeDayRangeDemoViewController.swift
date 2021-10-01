
import UIKit

final class LargeDayRangeDemoViewController: DemoViewController {

  // MARK: Internal

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Large Day Range"
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    guard !didScrollToInitialMonth else { return }

    let padding: CGFloat
    switch monthsLayout {
    case .vertical: padding = calendarView.layoutMargins.top
    case .horizontal: padding = calendarView.layoutMargins.left
    }

    let january1500CE = calendar.date(from: DateComponents(era: 1, year: 1500, month: 01, day: 01))!
    calendarView.scroll(
      toMonthContaining: january1500CE,
      scrollPosition: .firstFullyVisiblePosition(padding: padding),
      animated: false)

    didScrollToInitialMonth = true
  }

  override func makeContent() -> CalendarViewContent {
    let startDate = calendar.date(from: DateComponents(era: 0, year: 0100, month: 01, day: 01))!
    let endDate = calendar.date(from: DateComponents(era: 1, year: 2000, month: 12, day: 31))!

    return CalendarViewContent(
      calendar: calendar,
      visibleDateRange: startDate...endDate,
      monthsLayout: monthsLayout)
      .withInterMonthSpacing(24)
  }

  // MARK: Private

  private var didScrollToInitialMonth = false

}
