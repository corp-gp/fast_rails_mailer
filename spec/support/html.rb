# frozen_string_literal: true

def reformat_html(html)
  html
    .gsub(/\s+/, ' ') # Compact all whitespace to a single space
    .gsub(/> *</, ">\n<") # Use returns between tags
    .gsub(%r{<(\w+)([^>]*)>\n</\1>}, '<\1\2/>') # Auto close empty tags, e.g. <hr>\n</hr> => <hr/>
    .gsub(/ "/, '"').gsub(/\=" /, '="') # Remove leading/trailing spaces inside attributes
    .gsub(/ </, '<').gsub(/> /, '>') # Remove leading/trailing spaces inside tags
    .gsub(' data-parsed=""', '') # Don't consider this known inky-node artefact
    .gsub(' data-parsed>', '>') # Ditto
    .gsub('&#xA0;', ' ') # These are the same entity...
    .gsub(/(align="[^"]+") (class="[^"]+")/, '\2 \1') # Tweak order to match inky-node on container
    .gsub(/class\="([^"]+)"/) do # Sort class names
    classes = Regexp.last_match(1).split(' ').sort.join(' ')
    %(class="#{classes}")
  end
    .gsub(/<td height=".+?px"/) do |m| # Tweak out px until https://github.com/zurb/inky/pull/106 resolved
    m.gsub('px', '')
  end
end

def expect_same_html(input, expected)
  expect(reformat_html(input)).to eql(reformat_html(expected))
end

def expect_include_html(input, expected)
  expect(reformat_html(input)).to include(reformat_html(expected))
end
