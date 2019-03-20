class Hotline::Category < ApplicationRecord
  has_many :children, class_name: 'Hotline::Category', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :parent, class_name: 'Hotline::Category', optional: true
  has_many :services

  validates :href, presence: true, uniqueness: { message: 'no_uniqu' }
end
