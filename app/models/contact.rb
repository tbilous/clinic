class Contact < ActiveRecord::Base
  extend Dragonfly::Model
  include Avatarable
  dragonfly_accessor :photo
  
  belongs_to :user
  default_scope -> { order('name') }


  validates :name, length: { maximum: 60 }, presence: true
  validates :phone, length: { maximum: 25 }, presence: true
  # validates :email, length: { maximum: 60 }, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :comment, length: { maximum: 255 }, presence: true
  validates :address, length: { maximum: 255 }, presence: true
  validates :user_id, presence: true
  
  def avatar_text
    name.chr
  end
end