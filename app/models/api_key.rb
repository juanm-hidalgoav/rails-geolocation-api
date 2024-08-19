class ApiKey < ApplicationRecord
    belongs_to :user
    has_many :geolocations
  
    before_validation :generate_key, on: :create

    validates :key, presence: true, uniqueness: true
    validates :user_id, presence: true
    validate :check_expiration
  
    private

    def check_expiration
      if expires_at.present? && expires_at < Time.now
        errors.add(:expires_at, "must be in the future")
      end
    end

    def generate_key
      self.key ||= SecureRandom.hex(32)
    end

end