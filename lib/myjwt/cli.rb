require 'clipboard'
require 'jwt'
require 'thor'
require_relative 'user'

class Myjwt::CLI < Thor

  puts "Starting with JWT token generation."


  desc "encode", "encodes the token for the user input data"
  def encode
    result = accept_data
    token = JWT.encode result, nil, 'none'
    Clipboard.copy(token)
    say "Your JWT has been copied to the clipboard"
  end

  desc "decode(ARGV)", "decodes the token"
  def decode(token)
    data = JWT.decode token, nil, false
    puts data
  end

  no_commands {
    def accept_data
      result = {}
      count = 0
      new_key_flag = false
      required_keys = ["user_id", "email"]

      while (count < 2 || new_key_flag)
        new_key_flag = false
        count += 1

        key = ask("Enter key #{count}: ")
        val = ask("Enter #{key} value: ")

        result.merge!({key => val})

        if count >= 2
          choice = ask("Any additional inputs? (yes/no): ")
          case choice
          when "yes"
            new_key_flag = true
          else
            user = Myjwt::User.new(result)
            if !user.valid?
              say "required field(s) #{required_keys - result.keys} missing. Please provide the required input"
              new_key_flag = true
            elsif !user.valid_email?
              while !user.valid_email?
                val = ask "Invalid email entered! Enter email value: "
                result["email"] = val
                user.email = val
              end
              new_key_flag = false
            else
              return result
            end
          end
        end
      end
      result
    end
  }
end




