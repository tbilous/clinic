class Pharm < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('name') }


  validates_length_of :name,  in: 3..124
  validates_length_of :comment, in: 3..500
  validates_length_of :attention, in: 3..124
  validates_presence_of :user_id,  :name, :comment, :dose, :volume, :type_id, :pharmowner_id

end
