class Topic < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :user
  has_many :questions, :dependent => :destroy
  validates :title, presence: true, length: {minimum: 4}, uniqueness: {scope: :user}
end
