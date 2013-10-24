module HomeHelper
 def render_words_list(words_list)
  string_words = ""
  words_list.each do |word|
    string_words << "<li><span class='word'>#{word.word}</span><span class='translation'>#{word.translation}</span></li>"
  end
  return string_words.html_safe
 end

end
