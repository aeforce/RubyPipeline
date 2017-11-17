class UsersController < ApplicationController
  load_and_authorize_resource
  
  def index
    @users = current_user.subordinates
  end
  
  def new
    @roles = Role.all
  end
  
  def add_user
    @user           = User.new(user_params)
    @user.parent_id = current_user.id
    message         = ''
    if @current_user_role == AppConstants::MASTER
      amount = params[:user][:limit_amount].to_f
      if amount > 0 && amount <= current_user.remaining_amount
        @user.limit_amount = amount
      elsif amount > current_user.remaining_amount
        @user.limit_amount = 0.0
        message            = 'Amount can\'t exceed to your remaining amount'
      end
    end
    
    if @user.save
      if @user.limit_amount != 0.0 && @current_user_role != AppConstants::SUPER_ADMIN
        current_user.amount_used = current_user.amount_used + @user.limit_amount
        current_user.save!
      end
      role_name = current_user.roles.last.name
      role      = ''
      if role_name == AppConstants::SUPER_ADMIN
        role = AppConstants::COMPANY
      elsif role_name == AppConstants::COMPANY
        role = AppConstants::MASTER
      elsif role_name == AppConstants::MASTER
        role = AppConstants::CLIENT
      end
      
      @user.add_role role if role != ''
      
      flash[:success] = 'User successfully saved. ' + message
      redirect_to root_url
    else
      render :new
    end
  end
  
  def edit
    @roles = Role.all
  end
  
  def update_user
    @user   = User.find_by_id(params[:id])
    message = ''
    if @current_user_role == AppConstants::MASTER
      amount            = params[:user][:limit_amount].to_f
      is_correct_amount = false
      if amount > 0 && amount <= current_user.remaining_amount
        @user.limit_amount = @user.limit_amount + amount
        is_correct_amount  = true
      elsif amount > current_user.remaining_amount
        @user.limit_amount = @user.limit_amount
        message            = 'Amount can\'t exceed to your remaining amount'
      end
    end
    
    if @user.update(update_user_params)
      if is_correct_amount && @current_user_role == AppConstants::MASTER
        current_user.amount_used = current_user.amount_used + amount
        current_user.save!
      end
      
      @user.add_role params[:role]
      flash[:success] = 'User successfully updated. ' + message
      redirect_to root_url
    else
      flash[:danger] = 'User already exist'
      redirect_to :back
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone, :email, :password, :password_confirmation, :commission, :limit_amount)
  end
  
  def update_user_params
    params.require(:user).permit(:first_name, :last_name, :phone, :email, :password, :password_confirmation, :commission)
  end
end
