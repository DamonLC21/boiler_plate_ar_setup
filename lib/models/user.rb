class User < ActiveRecord::Base
    has_many :keywords
    has_many :songs, through: :keywords
end 