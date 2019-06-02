class User < ApplicationRecord
  
  # attr_accessor :name, :username
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :blogs
  
  # has_many :amol361s, class_name: "User", foreign_key: "user_id", dependent: :destroy
  
  has_many :amol361s, foreign_key: "user_id",  dependent: :destroy
  
end
