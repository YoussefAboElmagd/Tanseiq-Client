class HijriDateValidator {
  static const int _dhulQadah = 11; // ذو القعدة

  static const List<({int day, String label})> allowedPeriods = [
    (day: 20, label: 'الفرضية الداخلية'),
    (day: 24, label: 'الفرضية الرئيسية أولى'),
    (day: 29, label: 'الفرضية الرئيسية ثانية'),
  ];

  static bool isAccessAllowed() {
    final h = _toHijri(DateTime.now());
    return h.month == _dhulQadah && allowedPeriods.any((p) => p.day == h.day);
  }

  /// Converts a Gregorian date to Hijri using the Tabular Islamic Calendar algorithm.
  static ({int year, int month, int day}) _toHijri(DateTime date) {
    int m = date.month;
    int y = date.year;
    final int d = date.day;

    if (m < 3) {
      y -= 1;
      m += 12;
    }

    final double a = (y / 100.0).floorToDouble();
    final double b = 2.0 - a + (a / 4.0).floorToDouble();

    final double jd = (365.25 * (y + 4716)).floorToDouble() +
        (30.6001 * (m + 1)).floorToDouble() +
        d +
        b -
        1524.5;

    double l = jd - 1948438.5 + 0.5;
    final double n = (l / 10631.0).floorToDouble();
    l = l - 10631 * n;
    final double j = ((l - 1) / 354.3671).floorToDouble();
    final int hYear = (30 * n + j).truncate() + 1;
    l = l - (354.3671 * j).floorToDouble();
    final int hMonth = ((l - 1) / 29.5305).truncate() + 1;
    final int hDay = (l - (29.5305 * (hMonth - 1)).floorToDouble()).truncate();

    return (year: hYear, month: hMonth, day: hDay);
  }
}
