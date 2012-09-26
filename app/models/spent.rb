class Spent < ActiveRecord::Base
  self.primary_key = :id

  belongs_to :category
  belongs_to :user

  attr_accessible :amount, :date, :description, :user_id, :category_id

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :date, presence: true

  def self.create_or_update(attributes)
    id = attributes['id'] || attributes[:id]
    spent = self.find_by_id(id)

    if spent
      spent.update_attributes(attributes)
    else
      self.create(attributes)
    end
  end
end
