#:nodoc: all
class Character < ActiveRecord::Base
  include AASM

  aasm do
    state :sleeping, initial: true
    state :running

    event :run do
      transitions from: :sleeping, to: :running
    end

    event :sleep do
      transitions from: :running,  to: :sleeping
    end
  end

  belongs_to  :user
  has_many    :anthropometries, dependent: :destroy
  accepts_nested_attributes_for :anthropometries

  default_scope -> { order('created_at DESC') }

  # scope :patient, lambda { |dir| select('characters.*').WHERE(character_id = #{dir} }
  # scope :antropos_data, lambda { select('anthropometries.*').WHERE(character_id = #{dir} }

  validates :name, presence: true, length: { maximum: 20 }
  validates :comment, length: { maximum: 120 }
  validates :user_id, presence: true
  validates :birthday, presence: true
  validates :sex, inclusion: { in: [true, false] }
end
