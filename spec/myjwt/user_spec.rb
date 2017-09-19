require_relative '../spec_helper'
require_relative '../../lib/myjwt'

describe Myjwt::User do
  context "#valid?" do
    it "returns false if any of the required fields is nil" do
      user = Myjwt::User.new({"user_id" => "test"})
      expect(user.valid?).to eq(false)
    end

    it "returns true if both required fields are present" do
      user = Myjwt::User.new({"user_id" => "test", "email" => "email@gmail.com"})
      expect(user.valid?).to eq(true)
    end
  end

  context "#valid_email?" do
    it "returns nil if email not in correct format" do
      user = Myjwt::User.new({"user_id" => "test", "email" => "test"})
      expect(user.valid_email?).to eq(nil)
    end

    it "returns true if both required fields are present" do
      user = Myjwt::User.new({"user_id" => "test", "email" => "test@gmail.com"})
      expect(user.valid_email?).not_to eq(nil)
    end
  end
end