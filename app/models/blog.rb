class Blog < ApplicationRecord
  enum status: { draft: 0, published: 1 }
  
  belongs_to :user
  
end
