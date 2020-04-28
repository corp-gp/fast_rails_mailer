# frozen_string_literal: true

module FastPremailer
  class Railtie < Rails::Railtie
    config.app_generators.mailer template_engine: :fpm

    if config.respond_to?(:annotations)
      config.annotations.register_extensions('fpm') do |annotation|
        %r{//\s*(#{annotation}):?\s*(.*)$}
      end
    end

    initializer 'fast_premailer.configure_rails_initialization' do
      ActionView::Template.register_template_handler :fpm, TemplateHandler.new
      Mime::Type.register_alias 'text/html', :fpm
    end
  end
end
