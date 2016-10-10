module CharactersHelper
  def age(character)
    now_day = Date.today
    difference = now_day.year - character.birthday.year

    def days_calc(n)
      label = if n == 1
                t('days.one')
              elsif n > 1 && n < 0
                t('days.few')
              else
                t('days.many')
              end
      n.to_s + ' ' + label
    end

    def months_calc(n)
      label = if n == 1
                t('months.one')
              elsif n > 1 && n < 5
                t('months.few')
              else
                t('months.many')
              end
      n.to_s + ' ' + label
    end

    def years_calc(n)
      label = if n == 1
                t('years.one')
              elsif n > 1 && n < 5
                t('years.few')
              else
                t('years.many')
              end
      n.to_s + ' ' + label
    end

    if difference >= 1
      years_calc(difference)
    elsif difference < 1
      months = (now_day.year * 12 + now_day.month) - (character.birthday.year * 12 + character.birthday.month)
      if months >= 1
        months_calc(months)
      else
        days = (now_day.to_date - character.birthday.to_date).to_i
        days_calc(days, day)
      end
    else
      0
    end
  end

  def presence_characters(list)
    list.where(:usd == true).count > 0
  end

  def active_characters(list)
    list.where(:active == true).count > 0
  end

  def active_character(id)
    current_user.patient == id
  end

  def active_patient
    if current_user && current_user.patient?
      patient = Character.find_by_id(current_user.patient)
      patient
    end
  end

  def activate_character(id)
    current_user.update_attribute(:patient, id)
  end
end
