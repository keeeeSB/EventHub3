class User < ApplicationRecord
  mount_uploader :profile_image, ProfileImageUploader
  has_secure_password
  before_create :create_ctivation_token

  validates :name,  presence: true
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: URI::MailTo::EMAIL_REGEXP },
                    uniqueness: true

  private

    def create_activation_token
      self.activation_token = SecureRandom.urlsafe_base64
      self.activated = false
    end
end
