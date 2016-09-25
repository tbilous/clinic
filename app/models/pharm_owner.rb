class PharmOwner < ActiveRecord::Base
  belongs_to :user
  has_many :pharms, dependent: :nullify

  # default_scope -> { order('name') }

  validates_length_of :comment, in: 3..500
  validates_length_of :name,  in: 3..80
  validates_presence_of :user_id, :name

  # def pharms
  #   PharmOwner.where(id: Pharm.map(&:pharm_owner_id))
  # end
end
