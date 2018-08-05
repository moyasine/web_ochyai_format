class GenerateFormatController < ApplicationController
  def index
    @templete = Templete.new
  end
end
