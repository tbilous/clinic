class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :characters, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :pharm_groups, dependent: :destroy
  has_many :pharm_types, dependent: :destroy
  has_many :pharm_owners, dependent: :destroy
  has_many :pharms, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name
  validates_length_of   :name,  in: 4..30

  def anthropometries
    Anthropometry.where(character_id: characters.map(&:id))
  end
end
