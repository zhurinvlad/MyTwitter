class Micropost < ActiveRecord::Base
	validates :user_id, presence: true
	default_scope -> { order('created_at DESC') }
	validates :content, presence: true, length: { maximum: 140 }
	belongs_to :user
end
