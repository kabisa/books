class User < ApplicationRecord
  validates :email, presence: true,
    uniqueness: { case_sensitive: false },
    length: { maximum: 255 },
    email: true
  validates :name, length: { maximum: 100 }

  mount_uploader :avatar, AvatarUploader
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :crop_avatar

  def crop_avatar
    #byebug
    avatar.recreate_versions! if crop_x.present?
  end

  def anonymous?
    false
  end

  def identified?
    true
  end

  def invalidate_token
    update!(login_token: nil, login_token_valid_until: 1.year.ago)
  end

  def to_s
    email.inspect
  end

  def self.valid_with_token(token)
    where(login_token: token)
      .where('login_token_valid_until > ?', Time.now).first
  end
end
