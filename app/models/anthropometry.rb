#:nodoc: all
class Anthropometry < ActiveRecord::Base
  belongs_to :character

  validates_presence_of :date, :character_id
  validates :comment, length: { maximum: 120 }
  validates :weight, length: { maximum: 5 }
  validates :height, length: { maximum: 5 }
  validates :cranium, length: { maximum: 7 }
  validates :chest, length: { maximum: 7 }

  def character
    Character.where(id: character_id)
  end

  def user
    User.where(id: character.user_id)
  end
end
