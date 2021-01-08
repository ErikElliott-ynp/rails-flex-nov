class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?
    # C - current_user
    # R - require_logged_in
    # L - login
    # L - logout
    # L - logged_in?

    def current_user
        return nil unless session[:session_token]
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def require_logged_in
        redirect_to new_session_url unless logged_in?
    end

    def login(user)
        session[:session_token] = user.reset_session_token!
        @current_user = user
    end

    def logged_in?
        !!current_user
    end

    def logout
        if logged_in?
            current_user.reset_session_token!
            @current_user = nil
            session_token[:session_token] = nil
        end
    end

end
