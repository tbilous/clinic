module CharactersHelper
  def age(character)
    now_day = Date.today
    difference = now_day.year - character.birthday.year
    
    def days_calc(n)
      if n == 1 
        label = t('days.one')
      elsif n > 1 && n < 0
        label = t('days.few')
      else
        label = t('days.many')
      end
      n.to_s + ' ' + label
    end
    
    def months_calc(n)
      if n == 1 
        label = t('months.one')
      elsif n > 1 && n < 5
        label = t('months.few')
      else
        label = t('months.many')
      end
      n.to_s + ' ' + label
    end
    
    def years_calc(n)
      if n == 1 
        label = t('years.one')
      elsif n > 1 && n < 5
        label = t('years.few')
      else
        label = t('years.many')
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
          days_calc(days)
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
  
end
