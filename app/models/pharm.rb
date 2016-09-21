class Pharm < ActiveRecord::Base
  belongs_to :user
  belongs_to :pharm_owner
  belongs_to :pharm_type

  default_scope -> { order('name') }
  def self.search(search)
    where(['LOWER(name) ilike :search',
           'LOWER(comment) ilike :search'].join(' OR '), {search: "%#{search}%"})
  end

  validates_length_of :name,  in: 3..124
  validates_length_of :comment, in: 3..500
  validates_length_of :attention, in: 3..124
  validates_presence_of :user_id,  :name, :comment, :dose, :volume, :pharm_type_id, :pharm_owner_id

  # def owners
  #   PharmOwner.where(id: Pharm.map(&:pharm_owner_id))
  # end
end
