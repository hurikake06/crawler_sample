class Hotline::Service < ApplicationRecord
  belongs_to :category,class_name: 'Hotline::Category'
  validates :href, presence: true, uniqueness: { message: 'no_uniqu' }
end
