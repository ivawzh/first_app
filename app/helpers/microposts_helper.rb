module MicropostsHelper


  def wrap(content)
    sanitize(raw(content.split.map{ |s| wrap_long_string(s)}.join('')))
  end


  def no_long_words(content)
    content.split.each do |word|
      if word.length > 30
        return wrap(content)
      end
    end
    content
  end





  private

    def wrap_long_string(text, max_width = 30)
      zero_width_space = "&#8203;"
      regex = /.{1,#{max_width}}/
      (text.length < max_width) ? text : text.scan(regex).join(zero_width_space)
    end






































end