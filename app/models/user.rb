class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  validates :email, presence: true

  has_many :subordinates, class_name: "User", foreign_key: "parent_id"
  belongs_to :parent, class_name: "User"
  
  has_many :accounts, :foreign_key => 'donar_id'
  has_many :accounts, :foreign_key => 'receiver_id'


  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  
  def remaining_amount
    self.limit_amount - self.amount_used
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string(255)
#  last_name              :string(255)
#  phone                  :string(255)
#  parent_id              :integer
#  commission             :float(24)
#  limit_amount           :float(24)        default(0.0)
#  amount_used            :float(24)        default(0.0)
#
