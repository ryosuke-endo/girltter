Time::DATE_FORMATS[:YmdnHM] = -> (time) {
  date = time.to_date
  week = %w(日 月 火 水 木 金 土 日)[date.wday]
  time.strftime("%Y/%m/%d(#{week}) %H:%M")
}

Time::DATE_FORMATS[:Ymd] = '%Y/%m/%d'
