defprotocol Didata.Authorizer do
  def can?(user, action, params)
end
