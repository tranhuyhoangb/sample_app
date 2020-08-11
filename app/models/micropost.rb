class Micropost < ApplicationRecord
  MICROPOST_PARAMS = %i(content image).freeze

  belongs_to :user

  has_one_attached :image

  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.validations.post.content_length}
  validates :image, content_type: {in: Settings.validations.post.content_type, message:
    I18n.t("microposts.image_format")},
    size: {less_than: Settings.validations.post.max_file_size.megabytes, message:
      I18n.t("microposts.image_size")}

  scope :by_created_at, ->{order created_at: :desc}
end
