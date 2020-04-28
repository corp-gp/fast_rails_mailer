# frozen_string_literal: true

require 'inky'
require 'premailer'
require 'action_mailer'

# require 'fast_premailer/css_loaders'
# require 'fast_premailer/css_helper'
require 'fast_premailer/parser'
require 'fast_premailer/template_handler'
require 'fast_premailer/version'

module FastPremailer
  mattr_accessor :template_language
  @@template_language = :erb
end

require 'fast_premailer/railtie' if defined?(Rails)
