class Character < ActiveRecord::Base
  include AASM

  aasm do

    state :sleeping, :initial => true
    state :running

    event :run do
      transitions :from => :sleeping, :to => :running
    end


    event :sleep do
      transitions :from => :running,  :to => :sleeping
    end

  end
  belongs_to  :user
  # has_many    :antropometric, dependent: :destroy
  default_scope -> { order('created_at DESC') }

  validates :name, presence: true, length: { maximum: 20 }
  validates :comment, length: { maximum: 120 }
  validates :user_id, presence: true
  validates :birthday, presence: true
  validates :sex, inclusion: { in: [true, false] }
end
