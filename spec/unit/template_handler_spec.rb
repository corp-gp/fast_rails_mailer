# frozen_string_literal: true
# # frozen_string_literal: true
#
# require 'spec_helper'
#
# RSpec.describe FastPremailer::TemplateHandler do
#   describe '.call' do
#     it 'convert .slim' do
#       input = "<include_component path=\"#{path}\">".b
#       expected = <<-HTML
#         <table class="container" align="center">
#         </table>
#       HTML
#
#       template = ActionView::Template.registered_template_handler
#       output = FastPremailer::TemplateHandler.call(input).render
#       expect_same_html(output, expected)
#     end
#   end
#
# end
