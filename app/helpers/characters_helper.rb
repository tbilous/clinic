module CharactersHelper
  def age(character)
    now_day = Date.today
    difference = now_day.year - character.birthday.year

    if difference >= 1
      label = if difference == 1
                t('years.one')
              elsif difference > 1 && difference < 5
                t('years.few')
              else
                t('years.many')
              end
      difference.to_s + ' ' + label
    elsif difference < 1
      months = (now_day.year * 12 + now_day.month) - (character.birthday.year * 12 + character.birthday.month)
      if months >= 1
        label = if months == 1
                  t('years.one')
                elsif months > 1 && months < 5
                  t('years.few')
                else
                  t('years.many')
                end
        months.to_s + ' ' + label
      else
        days = (now_day.to_date - character.birthday.to_date).to_i
        label = if days == 1
                  t('days.one')
                elsif days > 1 && days < 0
                  t('days.few')
                else
                  t('days.many')
                end
        days.to_s + ' ' + label
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
