class Amol361 < ApplicationRecord
  
  attr_localized :paid
  
  validates :description, presence: true
  
  # belongs_to :user
  
  belongs_to :user
  
  scope :visible, -> { where(hidden: false) }
  # returns only visible xvaziri's

  def hide
  	update_attribute(:hidden, true)
  end

  # def show
  # 	update_attribute(:hidden, false)
  # end

  scope :hidden, -> { where(hidden: true) }

  def to_s
  	description
  end

  # def self.import(file)
  # 	CSV.foreach(file.path, headers: true) do |row|
  # 		Amol361.create! row.to_hash
  # 	end
  # end

  def self.search(search)
    
    # where (["description LIKE ? OR amount LIKE ? OR paid LIKE ? OR delndel LIKE ?", "%#{search}%","%#{search}%","%#{search}%","%#{search}%"]) 
    # where (["description::text ILIKE ? OR amount::text ILIKE ? OR paid::text ILIKE ?", "%#{search}%","%#{search}%","%#{search}%"])
    where (["description::text ILIKE ?", "%#{search}%"])
    # where (["description LIKE ?", "%#{search}%"])
  end

  # def self.import(file)
  #   CSV.foreach(file.path, headers: true) do |row|
  #     Note.create! row.to_hash
  #   end
  # end

   def self.import(file, user)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      note = find_by_id(row["id"]) || new(user: user)
      note.attributes = row.to_hash.slice(*row.to_hash.keys)
      note.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path)
    when ".xls" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end 
  end
  
class String
  def to_delocalized_decimal
    delimiter = I18n::t('number.format.delimiter')
    separator = I18n::t('number.format.separator')
    self.gsub(/[#{delimiter}#{separator}]/, delimiter => '', separator => '.')
  end
end

class ActiveRecord::Base
  def self.attr_localized(*fields)
    fields.each do |field|
      define_method("#{field}=") do |value|
        self[field] = value.is_a?(String) ? value.to_delocalized_decimal : value
      end
    end
  end
end



end
