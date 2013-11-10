module HomeHelper
 def render_words_list(words_list)
  string_words = ""
  words_list.each do |word|
    like_button = word.like ? "Unlike" : "Like"
    string_words << "<li><span class='word'>#{word.word}</span><span class='translation'>#{word.translation}</span><a value= '#{word.id}'href='#' class='like-word'>#{like_button}</a></li>"
  end
  return string_words.html_safe
 end

 def render_slide_item(list_words)
  html_string = ""
  list_words.each_with_index do |word, index|
    active = index == 0 ? "active" : nil
    html_string << "<div class='item #{active}'>"
    html_string <<   "<span class='word'>#{word.word}</span>"
    html_string <<   "<a class='btn btn-primary hint' href='#'>Translate</a>"
    html_string <<   "<span class='translation'>#{word.translation}</span>"
    html_string << "</div>"
  end
  return html_string.html_safe
 end

end
