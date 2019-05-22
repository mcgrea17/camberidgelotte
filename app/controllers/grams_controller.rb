class GramsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]

    
    def index
    end

    def new
        @gram = Gram.new
    end

    def show
        @gram = Gram.find_by_id(params[:id])
        return render_not_found if @gram.blank?
    end

    def edit
        @gram = Gram.find_by_id(params[:id])
        return render_not_found if @gram.blank?
        return render_not_found(:forbidden) if @gram.user != current_user
    end

    def update
        @gram = Gram.find_by_id(params[:id])
        return render_not_found if @gram.blank?
        
        return render_not_found(:forbidden) if @gram.user != current_user
        @gram.update_attributes(gram_params)
        
        return render_unprocessable_entity if !(@gram.valid?)
        redirect_to root_path 
    end

    def create
        @gram = current_user.grams.create(gram_params)
        return render_unprocessable_entity if !(@gram.valid?)
        redirect_to root_path 
    end

    def destroy
        @gram = Gram.find_by_id(params[:id])
        return render_not_found if !(@gram.present?)
        return render_not_found(:forbidden) if @gram.user != current_user
        @gram.destroy
        redirect_to root_path 
    end

    private

    def render_not_found(status=:not_found)
            render plain: '#{status.to_s.titleize} :(', status: status
    end

    def render_unprocessable_entity
        render :new, status: :unprocessable_entity
    end

    def gram_params
        params.require(:gram).permit( :message)
    end

end
