class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :devise_sign_up_params, if: :devise_controller? 
	before_action :set_locale
	before_action :get_q
  before_action :get_user_rat
  before_action :get_tags
  before_action :get_category_names
	 
	def default_url_options
      { locale: I18n.locale }
    end

	def set_locale
	  I18n.locale = params[:locale] || I18n.default_locale
	end


 private
  def devise_sign_up_params
	devise_parameter_sanitizer.permit(:sign_up,keys:[:attribute, :nickname])
  end

  def get_q
  	@q = Question.ransack(params[:q])
  end

  def get_user_rat
    @user_rat = Userparam.order(karma: :DESC).limit(10)
  end

  def get_tags
    #можна спецалізовано зробити для виводу самих цікавих тегів для користувача
    if current_user != nil && current_user.userparam.filter
      @tags=UserTag.where(user_id: current_user.id).order(score: :DESC).map{|tag| tag = tag.category}
    else
      @tags=Category.all
    end
  end

  def get_category_names
    @category_names= Category.all.collect(&:name).to_param
  end

end
