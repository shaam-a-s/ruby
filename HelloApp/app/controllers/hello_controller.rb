class HelloController < ApplicationController
  def ssn
    render json:"Hello from SSN"
  end

  def snu
    render json:"Hello from SNU"
  end
end
