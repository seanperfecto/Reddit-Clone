class SubsController < ApplicationController
  before_action :require_sign_in, except: [:index, :show]
  before_action :require_mod, only: [:edit, :update, :destroy]

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.user_id = current_user.id
    if @sub.save
      flash[:notice] = "Sub successfully created!"
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      flash[:notice] = "Sub successfully edited!"
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def destroy
    @sub = Sub.find(params[:id])
    @sub.destroy
    redirect_to subs_url
  end

  def require_mod
    @sub = Sub.find(params[:id])
    redirect_to subs_url unless @current_user.id == @sub.user_id
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
