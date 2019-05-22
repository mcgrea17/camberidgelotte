class GramsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create ]

    
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
    end

    def update
        @gram = Gram.find_by_id(params[:id])
        return render_not_found if @gram.blank?
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
        @gram.destroy
        redirect_to root_path 
    end

    private

    def render_not_found
            render plain: 'Not Found :(', status: :not_found
    end

    def render_unprocessable_entity
        render :new, status: :unprocessable_entity
    end

    def gram_params
        params.require(:gram).permit( :message)
    end

end
