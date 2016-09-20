class PharmType < ActiveRecord::Base
  belongs_to :user
  has_many :pharms, dependent: :nullify
  default_scope -> { order('name') }

  validates_length_of :comment, in: 3..500
  validates_length_of :name, in: 3..65
  validates_length_of :slug, in: 3..12
  validates_presence_of :user_id, :name, :slug


end
