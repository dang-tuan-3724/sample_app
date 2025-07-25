class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image do |attable|
    attable.variant :display, resize_to_limit: [ 500, 500 ]
  end
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 240 }
  validate :image_format

  private

  def image_format
    return unless image.attached?

    unless image.content_type.in?(%w[image/jpeg image/gif image/png ])
      errors.add(:image, "must be a valid image format")
    end
    unless image.byte_size <= 10.megabytes
      errors.add(:image, "size must be less than 10MB")
    end
  end
end
