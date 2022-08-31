class Relationship < ApplicationRecord
	# フォローしている関係
	belongs_to :follower, class_name: 'User'
	# フォローされている関係
	belongs_to :followed, class_name: 'User'
	validates :follower_id, uniqueness: { scope: :followed_id }
end
