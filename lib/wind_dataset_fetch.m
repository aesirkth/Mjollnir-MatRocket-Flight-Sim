function url_list = wind_dataset_fetch(station_number, start_date, end_date)


dates = start_date:hours(3):end_date;
possible_hours = [00 03 06 09 12 15 18 21];

found_date = false;

url_list = strings(0);


for i=1:numel(dates)

date = dates(i);
date.Hour = interp1(possible_hours, possible_hours, date.Hour, 'nearest');
date.Minute = 0;
date.Second = 0;

year_string = string(date.Year);
if date.Month < 10; month_str = "0"+string(date.Month); else; month_str = string(date.Month); end
if date.Day   < 10; day_str   = "0"+string(date.Day  ); else; day_str   = string(date.Day  ); end
if date.Hour  < 10; hour_str  = "0"+string(date.Hour ); else; hour_str  = string(date.Hour ); end



url = "https://weather.uwyo.edu/wsgi/sounding?datetime="+year_string+"-"+month_str+"-"+day_str+"%20"+hour_str+":00:00&id="+station_number+"&src=UNKNOWN&type=TEXT:CSV";


[~, found_date] = webread(url);

if found_date
disp("Dataset found: " + url)
url_list(end+1) = url;
writematrix(url_list, "urls.csv");

else
disp("Dataset not valid, trying again: " + url)
end


end


