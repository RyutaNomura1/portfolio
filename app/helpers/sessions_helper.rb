module SessionsHelper

  def current_user
    if (user_id = session[:user_id]) #代入
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        session[:user_id] = user.id
        @current_user = user
      end
    end
  end  
  
  def logged_in?
    !current_user.nil?
  end
end
