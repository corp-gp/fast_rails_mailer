# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FastPremailer::Parser do
  describe '.render' do
    it 'подгружает include_component' do
      path = "#{RSPEC_ROOT}/views/notice_mailer/table.erb"
      input = "<include_component path=\"#{path}\">".b
      expected = <<-HTML
        <table class="container" align="center"></table>
      HTML

      output = described_class.new(input).render
      expect_same_html(output, expected)
    end

    it 'рендерит фаил' do
      erb = "#{RSPEC_ROOT}/views/notice_mailer/email.erb"
      css = "#{RSPEC_ROOT}/views/notice_mailer/email.css"
      expected = <<-HTML
        <table class="container" align="center" style="" bgcolor="red">
      HTML

      output = described_class.new(File.read(erb), filename: erb, css_string: File.read(css)).render
      expect_include_html(output, expected)
    end
  end
end
