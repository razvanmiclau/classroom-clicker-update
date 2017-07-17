class Question < ActiveRecord::Base
  is_impressionable :through => :answers  #:unique => :request_hash to store unique sessions
  before_create :set_uuid
  self.primary_key = :uuid

  belongs_to :topic
  belongs_to :user
  has_many :choices, :dependent => :destroy
  has_many :answers, :dependent => :destroy

  accepts_nested_attributes_for :choices, reject_if: proc { |attributes| attributes['title'].blank?}, allow_destroy: true

  # VALIDATIONS
  validates :title,
    presence: true,
    length: {minimum: 6},
    uniqueness: {scope: :topic, case_sensitive: false , message: "Only once per topic"}

  private
    def set_uuid
      self.uuid = generate_uuid
    end

    def generate_uuid
      SecureRandom.uuid.gsub(/\-/,'')
    end
end
