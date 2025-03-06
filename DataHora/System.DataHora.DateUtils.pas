unit System.DataHora.DateUtils;

interface

type
  TDateUtils = class sealed
  public
    class function FirsDateOfMonth: TDate;
    class function LastDateOfMonth: TDate;
    class function FirstDateOfWeek: TDate;
    class function LastDateOfWeek: TDate;
    class function FirstDateOfPriorWeek: TDate;
    class function LastDateOfPriorWeek: TDate;
    class function FirsDateOfPriorMonth: TDate;
    class function LastDateOfPriorMonth: TDate;
    class function MonthsBetweenDates(AStartDate, AEndDate: TDate): Integer;
  end;

implementation

uses
  System.DateUtils,
  System.SysUtils;

{ TDateUtils }

class function TDateUtils.FirsDateOfMonth: TDate;
begin
  Result := EncodeDateTime(
    YearOf(Now),
    MonthOf(Now),
    1,
    0,
    0,
    0,
    0);
end;

class function TDateUtils.FirsDateOfPriorMonth: TDate;
var
  lData: TDate;
begin
  lData := IncMonth(
    Now,
    -1);
  Result := EncodeDateTime(
    YearOf(lData),
    MonthOf(lData),
    1,
    0,
    0,
    0,
    0);
end;

class function TDateUtils.FirstDateOfPriorWeek: TDate;
begin
  Result := StartOfTheWeek(IncWeek(Now, -1));
end;

class function TDateUtils.FirstDateOfWeek: TDate;
var
  lData: TDate;
begin
  lData := StartOfTheWeek(Now);
  Result := lData;
end;

class function TDateUtils.LastDateOfMonth: TDate;
begin
  Result := EncodeDateTime(
    YearOf(Now),
    MonthOf(Now),
    DaysInMonth(Now),
    0,
    0,
    0,
    0);
end;

class function TDateUtils.LastDateOfPriorMonth: TDate;
var
  lData: TDate;
begin
  lData := IncMonth(
    Now,
    -1);
  Result := EncodeDateTime(
    YearOf(lData),
    MonthOf(lData),
    DaysInMonth(lData),
    0,
    0,
    0,
    0);
end;

class function TDateUtils.LastDateOfPriorWeek: TDate;
begin
  Result := EndOfTheWeek(IncWeek(Now, -1));
end;

class function TDateUtils.LastDateOfWeek: TDate;
var
  lData: TDate;
begin
  lData := EndOfTheWeek(Now);
  Result := lData;
end;

class function TDateUtils.MonthsBetweenDates(AStartDate, AEndDate: TDate): Integer;
var
  lStartYear: Word;
  lStartMonth: Word;
  lStartDay: Word;
  lEndYear: Word;
  lEndMonth: Word;
  lEndDay: Word;
begin
  DecodeDate(
    AStartDate,
    lStartYear,
    lStartMonth,
    lStartDay);
  DecodeDate(
    AEndDate,
    lEndYear,
    lEndMonth,
    lEndDay);

  Result := (lEndYear - lStartYear) * 12 + (lEndMonth - lStartMonth);

  if (lEndYear = lStartYear) and (lEndMonth = lStartMonth) and (lEndDay < lStartDay) then
    Result := 0;

  if Result < 0 then
    Result := 0
end;

end.
