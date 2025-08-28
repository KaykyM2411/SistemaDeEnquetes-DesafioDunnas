class ApplicationController < ActionController::Base
  before_action :require_login
  helper_method :current_user, :logged_in?

  private 
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    unless logged_in?
      redirect_to login_path, alert: 'Voce precisa estarr logado para ter acesso a essa pagina'
    end
  end

  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: 'Essa pagina e de acesso restrito aos administradores'
    end
  end
  
  def require_non_admin
    if current_user&.admin?
      redirect_to root_path, alert: 'Administradores nao tem acesso a essas funcionalidades'
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
end
