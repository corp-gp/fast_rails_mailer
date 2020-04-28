# frozen_string_literal: true

module FastPremailer
  class TemplateHandler
    def engine_handler
      @engine_handler ||= ActionView::Template.registered_template_handler(FastPremailer.template_language)
    end

    def call(template, source = nil)
      if source
        source = FastPremailer::Parser.new(source, filename: template.identifier).render
        engine_handler.call(template, source)
      else
        engine_handler.call(template)
      end
    end
  end
end
