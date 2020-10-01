class Song < ActiveRecord::Base
    has_many :keywords
    has_many :users, through: :keywords
end 