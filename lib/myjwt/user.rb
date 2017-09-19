module Myjwt
  class User
    attr_accessor :user_id, :email, :details
    EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i


    def initialize(hash)
      @user_id = hash["user_id"]
      @email = hash["email"]
      other_keys = hash.keys - ["user_id", "email"]
      @details = {}
      other_keys.each do |key|
        @details[key] = hash[key]
      end
    end

    def valid?
      required_fields_present?
    end

    def valid_email?
      email.match(EMAIL_REGEX)
    end

    def to_s
      "user_id: #{@user_id}, email: #{email}, details: #{details}"
    end

    private

    def required_fields_present?
      !self.user_id.nil? && !self.email.nil?
    end

  end
end