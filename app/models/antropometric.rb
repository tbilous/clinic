class Antropometric < ActiveRecord::Base
  # belongs_to :character
  default_scope -> { order('date DESC') }


  
  validates :comment, length: { maximum: 120 }
  validates :character_id, presence: true
end
