class UserActivation
  attr_accessor :user

  def self.find(perishable_token)
    return new if perishable_token.blank?
    return new(:user => User.find_by_perishable_token(perishable_token))
  end

  def update_attributes(params)
    return false unless params[:user]
    user.active = true
    return user.update_attributes(params[:user])
  end

  def initialize(opts = {})
    self.user = opts[:user]
  end

  def valid?
    user && user.valid?
  end

  def errors
    user ? user.errors : []
  end

  def to_param
    id
  end

  def id
    @user.perishable_token
  end
end
