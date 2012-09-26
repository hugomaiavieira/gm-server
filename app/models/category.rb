class Category < ActiveRecord::Base
  self.primary_key = :id

  belongs_to :user
  has_many :spents

  attr_accessible :id, :name, :user_id

  validates :id, uniqueness: true
  validate :name_uniqueness

  def self.create_or_update(attributes)
    id = attributes['id'] || attributes[:id]
    category = self.find_by_id(id)

    if category
      category.update_attributes(attributes)
    else
      self.create(attributes)
    end
  end

  private

  def name_uniqueness
    if self.user.categories.collect(&:name).include?(self.name)
      errors.add(:name, 'should be uniq')
    end
  end
end
