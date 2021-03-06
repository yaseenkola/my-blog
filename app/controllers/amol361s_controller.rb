class Amol361sController < ApplicationController
	
  before_action :authenticate_user!
  
  before_action :set_amol361, only: [:show, :edit, :update, :destroy]
  
  def index
  	
  	 if current_user.admin
      # @users = User.all
      @amol361s = Amol361.all.search(params[:search]).order("created_at ASC")
    else
      @amol361s = current_user.amol361s.all.search(params[:search]).visible.order("created_at ASC") 
    end
    
    respond_to do |format|
      format.html
      format.js
    end
    
  #  @amol361s = current_user.amol361s.all.search(params[:search]).visible
  #  @amol361s = current_user.amol361s.all.visible
  #  @amol361s = Amol361.search(params[:search]).visible
		# respond_to do |format|
		# 	format.js
		# 	format.html 
		# end 
	end

	def import
		Amol361.import(params[:file], current_user)
		redirect_to amol361s_url, notice: "File was successfully imported."
	end

	def show
	end

	def new
		@amol361 = current_user.amol361s.build
		# @amol361 = Amol361.new
	end

	def create
		@amol361 = current_user.amol361s.build(amol361_params)
		# @amol361 = Amol361.new(amol361)
		if
		    @amol361.save
			flash[:notice] = 'Record was successfully Created'
			redirect_to amol361s_url
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @amol361.update(amol361_params)
			flash[:notice] = 'Record was successfully Updated'
			redirect_to amol361s_url
		else
			render 'edit'
		end

	end

	def destroy
		@amol361.destroy
		flash[:notice] = 'Record was successfully destroyed.'
		redirect_to amol361s_url 	
	end

	def hide
		@amol361 = Amol361.find(params[:id])
		@amol361.hide
		# flash[:notice] = 'Record was successfully hidden.'
		# redirect_to amol361s_url    
	end


	def unhide_all
		Amol361.hidden.update_all(hidden: false)
		redirect_to amol361s_path
	end

	def remove_all
		Amol361.delete_all
		flash[:notice] = "You have removed all results!"
		redirect_to amol361s_path
	end


	private
    # Use callbacks to share common setup or constraints between actions.
    def set_amol361
    	@amol361 = Amol361.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def amol361_params
    	params.require(:amol361).permit(:date, :description, :amount, :discount, :paid, :delndel, :remark, :balance)
    end
    
end
