class SsnController < ApplicationController
  def validate
    ssn = params[:ssn]
    result = SwedishSocialSecurityNumber.new(ssn).valid?
    render plain: result ? "The SSN is valid." : "The SSN is invalid."
  end
end
