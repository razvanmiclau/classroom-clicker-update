class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, password_length: 8..128

  has_many :topics, :dependent => :destroy
  has_many :questions, :through => :topics
  has_many :answers, :through => :questions

  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :first_name, presence:true, length: {maximum: 50, minimum: 1}
  validates :last_name, presence:true, length: {maximum:50, minimum: 1}
  validates :email, presence:true, length: {maximum:255},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
end
