class User < ActiveRecord::Base
	before_save { email.downcase! }
	has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :name, presence: true, length: { maximum: 50 }
	validates :email, presence: true,
			  format: { with: VALID_EMAIL_REGEX },
              uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, length: { minimum: 6 }
    before_create :create_remember_token
    has_many :followed_users, through: :relationships, source: :followed
    has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
    has_many :followers, through: :reverse_relationships, source: :follower

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
  def feed
    # Это предварительное решение. См. полную реализацию в "Following users".
   Micropost.from_users_followed_by(self)
  end
  
  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end
  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy!
  end

  private

	  def create_remember_token
	    self.remember_token = User.encrypt(User.new_remember_token)
	  end
end
