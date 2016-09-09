class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :encryptable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def method_missing(method)
    begin
      super
    rescue
      if method.to_s =~ /is_.*\?/
        return  role.downcase == method.to_s.gsub(/is_(.*)\?/, '\1').downcase
      else
        super
      end
    end
  end

  def in_authentication_group?(roles)
    roles.include? role
  end


end


# == Schema Information
#
# Table name: users
#
#  id                :integer         not null, primary key
#  username          :string(255)
#  email             :string(255)
#  persistence_token :string(255)
#  crypted_password  :string(255)
#  password_salt     :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  role              :string(255)
#
