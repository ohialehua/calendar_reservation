class Reservation < ApplicationRecord
  validates :name, presence: true
  validate :date_before_start
  validate :start_time_not_tuesday
  validate :start_time_not_thursday
  validate :time_only
  validates :start_time, uniqueness: { message: 'は他のユーザーが予約しています' }

  def date_before_start
    errors.add(:start_time, "は過去の日付を選択できません") if start_time < Date.today
  end

  def start_time_not_tuesday
    errors.add(:start_time, "は火曜日を選択できません") if start_time.tuesday?
  end

  def start_time_not_thursday
    errors.add(:start_time, "は木曜日を選択できません") if start_time.thursday?
  end

  def time_only
    if hour_only && min_only
      true
    else
      errors.add(:start_time, "9~19時の時間で、30分単位で予約してください")
    end
  end

  def hour_only
    start_time.hour < 19 and start_time.hour >9
  end

  def min_only
    start_time.min == 0 or 15 or 30 or 45
  end
end