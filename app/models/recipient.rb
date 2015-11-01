class Recipient < ActiveRecord::Base
  belongs_to :report
  validates_formatting_of :email, using: :email
end
