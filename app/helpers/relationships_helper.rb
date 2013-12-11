module RelationshipsHelper


  def store_current_location
    session[:return_to] = request.referrer
  end


end