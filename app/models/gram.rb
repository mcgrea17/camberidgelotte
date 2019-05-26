class Gram < ApplicationRecord
    belongs_to :user
    validates :message, presence: true, length: {minimum: 3}
    validates :picture, presence: true

    has_many :comments
    mount_uploader :picture, PictureUploader
end
