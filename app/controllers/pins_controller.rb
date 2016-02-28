class PinsController < ApplicationController
	before_action :find_pin, only: [:show, :edit, :update, :destroy, :upvote]
	def index
		@pins = Pin.all.order("created_at DESC")
	end

	def new
		@pin = current_user.pins.build
	end

	def create
		@pin = current_user.pins.build(pin_params)
		if @pin.save
			redirect_to @pin, notice: "successfully created a new pin"
		else
			render 'new'
		end
	end

	def show

	end

	def update
		if @pin.update(pin_params)
			redirect_to @pin, notice: "pin was successfully updated"
		else
			render 'edit'
		end
	end

	def destroy
    @pin.destroy
    redirect_to root_path, notice:"Pin deleted"
	end
  
	def upvote
		@pin.upvote_by current_user
		redirect_to :back
	end
	private
		def pin_params
			params.require(:pin).permit(:title, :description, :image)
		end

		def find_pin
			@pin = Pin.find(params[:id])
		end

end
