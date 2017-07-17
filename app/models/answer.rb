class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  validates :value,
    presence: true,
    length: {in: 2..140}
end
