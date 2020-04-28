# frozen_string_literal: true

module FastPremailer
  class Parser
    class ParseError < StandardError; end

    attr_reader :html_string, :template, :path, :file, :css_string

    def initialize(html_string, template: nil, filename: nil, css_string: nil)
      if html_string.encoding.name == 'ASCII-8BIT'
        html_string.force_encoding('utf-8')
      end

      @html_string = html_string
      @css_string = css_string
      @template = template

      if filename || template&.identifier
        @path, @file = File.split(filename || template.identifier)
      end
    end

    def render
      html = transform_doc(@html_string)
      html = Inky::Core.new.release_the_kraken(block_erb(html))
      pm = Premailer.new(
          html,
          css_string:        @css_string,
          output_encoding:   'utf-8',
          with_html_string:  true,
          include_link_tags: true,
          adapter:           :nokogiri,
          )
      @html_string = unblock_erb(pm.to_inline_css)
    end

    def transform_doc(html)
      regex = /<include_component\s*path="(.*)"[^>]*>/
      html.each_line.map do |line|
        while elem = line.match(regex)
          component = File.read(File.join(@path.to_s, elem[1]))
          line.sub!(regex, transform_doc(component))
        end
        line
      end.join
    end

    def block_erb(html)
      # блокировка erb блоков
      regexp_erb_block = /<%[^%>]*[\s-]%>/
      html.gsub!(regexp_erb_block, '<!--ERB \0 ERB-->')

      # разблокировка стилей
      # regexp_stylesheet_unblock = /<!--ERB (<%=\s+(stylesheet_link_tag|stylesheet_pack_tag)[^%>]*[\s-]%>) ERB-->/
      # html.gsub!(regexp_stylesheet_unblock, '\1')
    end

    def unblock_erb(html)
      # разблокировка erb блоков
      regexp_erb_block = /<!--ERB (<%=[^%>]*[\s-]%>) ERB-->/
      html.gsub!(regexp_erb_block, '\1')
    end
  end
end
