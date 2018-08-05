require 'pango'

class OchiaiFormatGenerator
  def initialize(width, height)
    @width = width
    @height = height
    @surface =    Cairo::ImageSurface.new(Cairo::FORMAT_ARGB32, width, height)
    @context = Cairo::Context.new(@surface)
    @header_height = @height/9
    @title_height = @header_height*2/3
    @image_area_height = @height/2.5 - @header_height
    @body_height = @height - @header_height - @image_area_height
    set_body
    set_header
    set_content_headers
  end

  def set_title(title)
    @context.set_source_rgb(1, 1, 1)
    x, y = generate_extent(title, @width, @title_height, 32)
    @context.move_to(x, y)
    @context.show_text(title)
  end

  def set_author(author)
    author_height = @header_height / 3
    @context.set_source_rgb(1, 1, 1)
    x, y = generate_extent(author, @width, author_height, 24)
    @context.move_to(x, y + @title_height)
    @context.show_text(author)
  end

  def set_image(image_path)
    image = Cairo::ImageSurface.from_png(image_path)
    scale = (@image_area_height.to_f / image.height) * 0.95
    @context.scale(scale, scale)
    @context.set_source(image, 0, @header_height / scale)
    @context.paint
  end

  def set_content(x, y, message)
    @context.set_source_rgb(0.4, 0.4, 0.4)
    @context.set_font_size(64* Pango::SCALE)
    @context.move_to(x, y)
    # @context.show_text(message)

    #TODO: 文字が折り返されるようにする必要あり
    layout = @context.create_pango_layout
    layout.wrap = Pango::WrapMode::CHAR
    layout.set_font_description(Pango::FontDescription.new("Hiragino Kaku Gothic Pro 20"))
    layout.width = 600 * Pango::SCALE
    layout.set_wrap(layout.wrap)
    layout.text = message

    @context.show_pango_layout(layout)
  end

  def save_to_png(filename)
    @surface.write_to_png("#{filename}.png")
  end

  private
  def set_body
    @context.select_font_face('Hiragino Kaku Gothic Pro')
    @context.set_source_rgb(1, 1, 1) # white
    @context.rectangle(0, 0, @width, @height)
    @context.fill
  end

  def set_header
    @context.set_source_rgb(0.6, 0.6, 0.6) # gray
    @context.rectangle(0, 0, @width, @header_height)
    @context.fill
  end

  # 中央揃えのための座標を出力する
  def generate_extent(string, area_width, area_height, font_size)
    @context.set_font_size(font_size)
    extents = @context.text_extents(string)
    x = area_width/2 - (extents.width/2 + extents.x_bearing)
    y = area_height/2 - (extents.height/2 + extents.y_bearing)
    [x, y]
  end

  def set_content_headers
    set_content_header(0, @height*2/5, 'どんなもの？')
    set_content_header(0, @height*3/5, '先行研究と比べてどこがすごい？')
    set_content_header(0, @height*4/5, '技術や手法のキモはどこ？')
    set_content_header(@width/2, @height*2/5, 'どうやって有効だと検証した？')
    set_content_header(@width/2, @height*3/5, '議論はある？')
    set_content_header(@width/2, @height*4/5, '次に読むべき論文は？')
  end

  def set_content_header(x, y, title, adjust_size=50)
    content_header_width = @width/2 - 2*adjust_size
    content_header_height = @height/18
    @context.set_source_rgb(0.4, 0.4, 0.4)
    @context.rounded_rectangle(x + adjust_size, y, content_header_width, content_header_height, 20)
    @context.stroke
    extent_x, extent_y = generate_extent(title, content_header_width + 2*adjust_size, content_header_height, 24)
    @context.move_to(x + extent_x, y + extent_y)
    @context.show_text(title)
  end
end
