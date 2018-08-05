class TempletesController < ApplicationController
  def index
  end

  def new
  end

  def create
    @templete = Templete.new(templete_params)
    require 'ochiai_format_generator.rb'


    width = 1600
    height = 900
    plus_height = 240
    g = OchiaiFormatGenerator.new(width, height)
    g.set_title(@templete.title)
    g.set_author(@templete.author)

# g.set_image("sample_picture.png")
    g.set_content(100, height*1/5+plus_height, @templete.what_thing.to_s)
    g.set_content(100, height*2/5+plus_height, @templete.where_good.to_s)
    g.set_content(100, height*3/5+plus_height, @templete.where_kimo.to_s)

    g.set_content(900, height*1/5+plus_height, @templete.how_effective.to_s)
    g.set_content(900, height*2/5+plus_height, @templete.what_discussion.to_s)
    g.set_content(900, height*3/5+plus_height, @templete.what_next.to_s)


    g.save_to_png(@templete.title)

    send_file "#{@templete.title}.png", type: 'image/png', disposition: 'inline'







  end
  private

  def templete_params
    params.require(:templete).permit(:title, :author,:what_thing,:where_good,:where_kimo,:how_effective,:what_discussion,:what_next)
  end
end
