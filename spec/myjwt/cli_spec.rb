require_relative '../spec_helper'
require_relative '../../lib/myjwt'

describe Myjwt::CLI do
  let(:test_data) {{"user_id" => "vaidehi", "email" => "vaidehi@gmail.com"}}

  context "#encode" do
    it "creates jwt and copies in clipboard" do
      allow_any_instance_of(Myjwt::CLI).to receive(:accept_data).and_return(test_data)

      expect(Clipboard).to receive(:copy)
      expect(JWT).to receive(:encode).with(test_data, nil, 'none')
      expect do
        Myjwt::CLI.new.encode
      end.to output("Your JWT has been copied to the clipboard\n").to_stdout
    end
  end


  context "#decode" do
    it "accepts string and decodes the token" do
      token = JWT.encode test_data, nil, 'none'

      expect(JWT).to receive(:decode).with(token, nil, false)

      Myjwt::CLI.new.decode(token)
    end
  end
end