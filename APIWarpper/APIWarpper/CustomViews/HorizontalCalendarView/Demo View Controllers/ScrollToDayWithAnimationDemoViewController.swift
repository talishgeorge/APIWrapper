
import UIKit

final class ScrollToDayWithAnimationDemoViewController: DemoViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Scroll to Day with Animation"
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    let july2020 = calendar.date(from: DateComponents(year: 2020, month: 07, day: 11))!
    calendarView.scroll(
      toDayContaining: july2020,
      scrollPosition: .centered,
      animated: true)
  }

  override func makeContent() -> CalendarViewContent {
    let startDate = calendar.date(from: DateComponents(year: 2016, month: 07, day: 01))!
    let endDate = calendar.date(from: DateComponents(year: 2020, month: 12, day: 31))!

    return CalendarViewContent(
      calendar: calendar,
      visibleDateRange: startDate...endDate,
      monthsLayout: monthsLayout)
      .withInterMonthSpacing(24)
  }

}
