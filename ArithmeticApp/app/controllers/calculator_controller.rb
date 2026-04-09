class CalculatorController < ApplicationController
  def index
  end
  def calculate
    @num1=params[:num1].to_f
    @num2=params[:num2].to_f
    @operation=params[:operation]

    if @operation=="+"
      @result=@num1+@num2
    
    elsif @operation=="-"
      @result=@num1-@num2
    elsif @operation=="*"
      @result=@num1*@num2
    elsif @operation=="/"
      if @num2==0
        @error="Cannot divide"
      else
        @result=@num1/@num2
      end
    end

    render :index
  end
end
