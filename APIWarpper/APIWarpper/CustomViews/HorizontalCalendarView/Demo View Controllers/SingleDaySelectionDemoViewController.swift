
import UIKit

final class SingleDaySelectionDemoViewController: DemoViewController {

  // MARK: Lifecycle

  required init(monthsLayout: MonthsLayout) {
    super.init(monthsLayout: monthsLayout)
    selectedDate = calendar.date(from: DateComponents(year: 2020, month: 01, day: 19))!
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Internal

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Single Day Selection"
    calendarView.daySelectionHandler = { [weak self] day in
      guard let self = self else { return }

      self.selectedDate = self.calendar.date(from: day.components)
        print(self.selectedDate)
        
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
    let startDate = calendar.date(from: DateComponents(year: 2021, month: 08, day: 01))!
    let endDate = calendar.date(from: DateComponents(year: 2021, month: 10, day: 31))!

    let selectedDate = self.selectedDate
    let defaultSelectedDate = calendar.date(from: DateComponents(year: 2021, month: 10, day: 08))!
    
    return CalendarViewContent(
      calendar: calendar,
      visibleDateRange: startDate...endDate,
      monthsLayout: monthsLayout)

      .withInterMonthSpacing(24)
      .withVerticalDayMargin(8)
      .withHorizontalDayMargin(8)

      .withDayItemModelProvider { [calendar, dayDateFormatter] day in
        var invariantViewProperties = CalendarDayView.InvariantViewProperties.baseInteractive
        
        let date = calendar.date(from: day.components)
        if date == selectedDate {
          invariantViewProperties.backgroundShapeDrawingConfig.borderColor = .yellow
          invariantViewProperties.textColor = .white
          invariantViewProperties.backgroundShapeDrawingConfig.fillColor = .black
        //invariantViewProperties.backgroundShapeDrawingConfig.fillColor = .blue.withAlphaComponent(0.15)
        }

        if date == defaultSelectedDate {
          invariantViewProperties.backgroundShapeDrawingConfig.borderColor = .yellow
          invariantViewProperties.textColor = .white
          invariantViewProperties.backgroundShapeDrawingConfig.fillColor = .blue
        //invariantViewProperties.backgroundShapeDrawingConfig.fillColor = .blue.withAlphaComponent(0.15)
            print(date)
            print(defaultSelectedDate)
        }
        
        let weekDay = Calendar.current.component(.weekday, from: date!)
        
        if weekDay == 1 || weekDay == 7 {
            //invariantViewProperties.backgroundShapeDrawingConfig.borderColor = .yellow
            //invariantViewProperties.textColor = .red
            invariantViewProperties.shape = .rectangle()
            invariantViewProperties.backgroundShapeDrawingConfig.fillColor = UIColor.lightGray.withAlphaComponent(0.15)
        }
        
        return CalendarItemModel<CalendarDayView>(
          invariantViewProperties: invariantViewProperties,
          viewModel: .init(
            dayText: "\(day.day)",
            accessibilityLabel: date.map { dayDateFormatter.string(from: $0) },
            accessibilityHint: nil))
      }
    
    
  }

  // MARK: Private

  private var selectedDate: Date?

}

extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
        // or use capitalized(with: locale) if you want
    }
    
    func dayNumberOfWeek() -> Int? {
         return Calendar.current.dateComponents([.weekday], from: self).weekday
     }
}
