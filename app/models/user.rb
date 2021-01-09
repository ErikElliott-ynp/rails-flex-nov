class User < ApplicationRecord
    validates :email, :password_digest, presence: true
    validates :username, :session_token, presence: true, uniqueness: true
    validates :password, length: { minimum: 6 },allow_nil: true

    attr_reader :password
    # attr_reader is used in the validation of the password
    
    after_initialize :ensure_session_token
    # before_validation :ensure_session_token
    # set the session_token using the ensure_session_token method

    has_many :chirps
        foreign_key: :user_id,
        class_name: :Chirp

    # S - self.find_by_credentials
    # P - password=
    # I - is_password?
    # R - reset_session_token!
    # E - ensure_session_token

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        # find the user by their username
        user && user.is_password?(password) ? user : nil
        # return nil is the find_by method returns nil
        # use the User#is_password? method to compare the password give with the password_digest from the DB
        # return the user is they match or return nil
    end

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        # create the hashed/salted password_digest from the given password using BCrypt
        @password = password
        # set an instance variable for use in the validation
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
        # create a new instance of the BCrypt::Password class with the password_digest for this instance
        # then call the BCrypt::Password#is_password? method to compare the given password
        # (this method does not use any recursion)
    end

    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
        # set the session token to a new random string
        self.save!
        # .save! throws and errow and stops code execution= => easier to debug
        self.session_token
        # return the value of the session token for use later
    end

    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64
        # makes sure the user has a session_token when first created
        # the ||= is important later for logging in!
        
    end
end
