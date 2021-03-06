module SessionsHelper

  def sign_in(user)
    if params[:remember_me]
      cookies.permanent[:remember_token] = user.remember_token
    else
      cookies[:remember_token] = user.remember_token
    end
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= my_remember_token if cookies[:remember_token]
  end

  def current_user?(user)
    user == current_user
  end

  def current_project_user?(project)
    project.user_id == current_user.id || current_user.admin?
  end

  def correct_project_user
    @project = Project.find(params[:id])
    correct_user(@project)
  end

  def correct_user(project)
    if !current_project_user?(project)
      flash[:error] = 'You are not the owner of this project!'
      redirect_to(root_path)
    end
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end

  private

    def my_remember_token
      user = User.find_by_remember_token(cookies[:remember_token])
      if user
        user.lastlogin = Time.now
        user.logincnt += 1
        user.no_remember_token = true
        user.save!(:validate => false)
      end
      user
    end

end
