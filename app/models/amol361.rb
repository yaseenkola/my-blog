class Amol361 < ApplicationRecord 
 validates :description, presence: true 

 # attr_accessor :paid_input 
 # validate :check_paid_input 

 # def check_paid_input 
 #  paid = paid_input 
 #  p "paid: #{paid}, paid_input: #{paid_input}" 
 #  errors.add(:paid, '- Commas are not allowed') if paid_input.to_s.include?(',') 
 #  paid = paid_input.gsub(/,/, " ")
 # end
 
 # validates :paid, numericality: { only_integer: true }, allow_nil: true
 

 # validate :custom_validation
 
 #  def custom_validation
 #    if paid_input.to_s.include?(',')
 #     errors.add(:paid, '- Commas are not allowed')
 #    end
 #  end

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
    #where (["description::text ILIKE ?", "%#{search}%"])
    where (["description LIKE ? OR amount LIKE ? OR paid LIKE ? OR delndel ILIKE ?", "%#{search}%","%#{search}%","%#{search}%","%#{search}%"]) 

    #where (["description LIKE ?", "%#{search}%"])
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

end
