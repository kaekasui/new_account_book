class User::Updator
  include ActiveModel::Model

  def initialize(user: nil, params: nil)
    @user = user
    @params = params
  end

  def save
    return false if invalid?
    p "メール送信" if @params[:new_email]
    p "パラメータを変更" if @params[:new_email].blank?
    if @user.update(@params)
      true
    else
      errors[:base] << @user.errors.full_messages.join(',')
      false
    end
  end
end
