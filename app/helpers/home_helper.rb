module HomeHelper
 def render_words_list(words_list)
  string_words = ""
  words_list.each do |word|
    like_button = word.like ? "Unlike" : "Like"
    string_words << "<li><span class='word'>#{word.word}</span><span class='translation'>#{word.translation}</span><a value= '#{word.id}'href='#' class='like-word'>#{like_button}</a></li>"
  end
  return string_words.html_safe
 end

end
