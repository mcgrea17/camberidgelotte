class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :gram
    validates :message, presence: true, length: {minimum: 3}
   
    
end
