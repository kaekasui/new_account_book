class User::Updator
  def initialize(user: nil, params: nil)
    @user = user
    @params = params
  end

  def save
    p 'new_email exists' if @params[:new_email]
    @user.update(@params)
  end
end
