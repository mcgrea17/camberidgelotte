class Gram < ApplicationRecord
    belongs_to :user
    validates :message, presence: true, length: {minimum: 3}
end
