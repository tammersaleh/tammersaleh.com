Time::DATE_FORMATS[:short_date] = "%x"             # 04/13/10
Time::DATE_FORMATS[:long_date]  = "%a, %b %d, %Y", # Tue, Apr 13, 2010
Time::DATE_FORMATS[:w3c]        = lambda {|time| time.utc.strftime("%Y-%m-%dT%H:%M:%S+00:00") }
